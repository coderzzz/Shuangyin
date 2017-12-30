//
//  PhotoManager.m
//  DisableOtherAudioPlaying
//
//  Created by vedon on 18/9/13.
//  Copyright (c) 2013 com.vedon. All rights reserved.
//

#import "PhotoManager.h"
#import "VideoModel.h"

@implementation PhotoManager
@synthesize camera;
@synthesize pickingImageView;
@synthesize configureBlock;
@synthesize video;
+(PhotoManager *)shareManager
{
    static PhotoManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       manager = [[PhotoManager alloc]init];
    });
    return manager;
 
}

-(id)init
{
    self = [super init];
    if (self) {
        isSaveToLibrary = NO;
        [self initCamera];
        [self initVideo];
        [self initlizationPickImageView];
    }
    return  self;
}

-(void)initCamera
{
    camera = [[UIImagePickerController alloc] init];
	camera.delegate = self;
	camera.allowsEditing = NO;
    isSaveToLibrary = NO;
    qualityNum = 0;
	//检查摄像头是否支持摄像机模式
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		camera.sourceType = UIImagePickerControllerSourceTypeCamera;
 
            camera.mediaTypes = @[(NSString*)kUTTypeImage];
        
	}
	else
	{
		NSLog(@"Camera not exist");
		return;
	}
	
    //仅对视频拍摄有效
	switch (qualityNum) {
		case 0:
			camera.videoQuality = UIImagePickerControllerQualityTypeHigh;
			break;
		case 1:
			camera.videoQuality = UIImagePickerControllerQualityType640x480;
			break;
		case 2:
			camera.videoQuality = UIImagePickerControllerQualityTypeMedium;
			break;
		case 3:
			camera.videoQuality = UIImagePickerControllerQualityTypeLow;
			break;
		default:
			camera.videoQuality = UIImagePickerControllerQualityTypeMedium;
			break;
	}
	
}
-(void)initVideo
{
    video = [[UIImagePickerController alloc] init];
    video.delegate = self;
    video.allowsEditing = NO;
    isSaveToLibrary = NO;
    qualityNum = 0;
    //检查摄像头是否支持摄像机模式
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        video.sourceType = UIImagePickerControllerSourceTypeCamera;
      
            video.mediaTypes = @[(NSString*)kUTTypeMovie];
            video.videoMaximumDuration  = 300;
        
        
    }
    else
    {
        NSLog(@"Camera not exist");
        return;
    }
    
    //仅对视频拍摄有效
    switch (qualityNum) {
        case 0:
            video.videoQuality = UIImagePickerControllerQualityTypeHigh;
            break;
        case 1:
            video.videoQuality = UIImagePickerControllerQualityType640x480;
            break;
        case 2:
            video.videoQuality = UIImagePickerControllerQualityTypeMedium;
            break;
        case 3:
            video.videoQuality = UIImagePickerControllerQualityTypeLow;
            break;
        default:
            video.videoQuality = UIImagePickerControllerQualityTypeMedium;
            break;
    }
    
}
-(void)initlizationPickImageView
{
    if (pickingImageView) {
        pickingImageView = nil;
    }
    pickingImageView= [[UIImagePickerController alloc] init];
	pickingImageView.delegate = self;
	pickingImageView.allowsEditing = NO;
	
	pickingImageView.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
        //混合类型 photo + movie
		pickingImageView.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }

}

#pragma  mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
	[picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	if([mediaType isEqualToString:@"public.movie"])			//被选中的是视频
	{
		 NSURL *videoURL = info[UIImagePickerControllerMediaURL];
		
		if (isSaveToLibrary)
		{
			//保存视频到相册
			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
			[library writeVideoAtPathToSavedPhotosAlbum:videoURL completionBlock:nil];
            library = nil;
		}
		
		//获取视频的某一帧作为预览
        UIImage * image = [self getPreViewImg:videoURL];
        VideoModel *model = [[VideoModel alloc]init];
        model.image = image;
        model.videoURL = videoURL;
        if(self.configureBlock)
        {
            self.configureBlock(model);
        }

//        image = nil;
	}
    else if([mediaType isEqualToString:@"public.image"])	//被选中的是图片
	{
        //获取照片实例
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if(self.configureBlock)
        {
            self.configureBlock(image);
        }
		if (isSaveToLibrary)
		{
			ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
			[library writeImageToSavedPhotosAlbum:[image CGImage]
									  orientation:(ALAssetOrientation)[image imageOrientation]
								  completionBlock:nil];
            library = nil;
		}
		
	}
	else
	{
		NSLog(@"Error media type");
		return;
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	NSLog(@"Cancle it");
	[picker dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}


-(UIImage *)getPreViewImg:(NSURL *)url
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    //截取视频第一帧的图片
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
}



@end
