

#import "ThirdViewController.h"
#include <sys/sysctl.h>
#include <sys/utsname.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface ThirdViewController ()

@property (nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic) NSMutableArray *capturedImages;


@end

@implementation ThirdViewController
@synthesize picker;
@synthesize profilePic;


//logout
- (IBAction)logout:(UIButton *)sender {
   [PFUser logOut];
    if(![PFUser currentUser]){
    [self.tabBarController performSegueWithIdentifier:@"loginView" sender:nil];
    }
}
+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

//print out
@synthesize username;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [profilePic addGestureRecognizer:singleTap];
    
    
    //background pic
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = [UIImage imageNamed:@"bg4"];
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundImageView.layer.zPosition = -1;
    [self.view addSubview:backgroundImageView];
    
    //jenny add
    NSString *str;
    
    str = [[NSMutableString alloc] init];
    
   /* PFQuery *query = [PFQuery queryWithClassName:@"HiRoomi"];
    [query getObjectInBackgroundWithId:@"Sj9v1SxpTq" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", gameScore);
    }];*/
    
    
    //PFQuery *query = [PFQuery queryWithClassName:@"HiRoomi"]; //1
    PFUser *user = [PFUser currentUser];
    
    NSString *yourName = user[@"fullName"];
    
    NSLog(@"%@", user[@"fullName"]);
   // username.text = user.username;
    str = [NSString stringWithFormat:@"Hello %@", yourName];
    username.text = str;
    
    
    
   // [query whereKey:@"email" equalTo:@"nijianing@163.com"];//2
    //[query whereKey:@"Score" greaterThan:[NSNumber numberWithInt:1000]]; //3
   /* [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            NSLog(@"Successfully retrieved: %@", objects);
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
    }];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
-(void)onClickImage{
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Add Project Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Photos", nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) { return; }
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"Item A Selected");
            
            picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            //picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:picker animated:YES completion:NULL];
            break;
        }
        case 1:
        {
            NSLog(@"Item B Selected");
            
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            
            break;
        }
            
    }
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie,kUTTypeImage, nil];
    imagePickerController.delegate = self;
    
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        imagePickerController.showsCameraControls = NO;
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
        imagePickerController.cameraOverlayView = self.overlayView;
        self.overlayView = nil;
    }
    
    self.picker = imagePickerController;
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker2
 didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        
        
    }
    
    // Handle a movied picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSString *moviePath = [[info objectForKey:
                                UIImagePickerControllerMediaURL] path];
        
        // Do something with the picked movie available at moviePath
        
        
    }
    self.profilePic.contentMode = UIViewContentModeScaleAspectFit;
    self.profilePic.clipsToBounds = YES;
    [self.profilePic setImage:originalImage];
    //[self.capturedImages addObject:originalImage];
    
    
    
    
    [picker2 dismissViewControllerAnimated:YES completion:NULL];
    
    // [self finishAndUpdate];
}

- (void)finishAndUpdate
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if ([self.capturedImages count] > 0)
    {
        if ([self.capturedImages count] == 1)
        {
            // Camera took a single picture.
            [self.imageView setImage:[self.capturedImages objectAtIndex:0]];
        }
        else
        {
            
          
            
            // Camera took multiple pictures; use the list of images for animation.
            self.profilePic.animationImages = self.capturedImages;
            self.profilePic.animationDuration = 5.0;    // Show each captured photo for 5 seconds.
            self.profilePic.animationRepeatCount = 0;   // Animate forever (show all photos).
            [self.profilePic startAnimating];
        }
        
        // To be ready to start again, clear the captured images array.
        [self.capturedImages removeAllObjects];
    }
    
    //jenny add, let profile picture fit the size
    CGSize imageSize = profilePic.image.size;
    [profilePic sizeThatFits:imageSize];    
    
    self.picker = nil;
}




- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker3 {
    [picker3 dismissViewControllerAnimated:YES completion:NULL];
}


//-(IBAction)UploadImage:(id)sender {
    // Convert to JPEG with 50% quality
    //[ImageView setImage:imageToSave];
    
   // UIImage *imageToSave;
//[ImageView setImage:imageToSave];

    
  // }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
