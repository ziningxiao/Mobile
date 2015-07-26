

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ParseUI/ParseUI.h>

@interface ThirdViewController : UIViewController <UINavigationBarDelegate, UIImagePickerControllerDelegate> {
    
    UIImagePickerController *picker;
    UIImage *image;
    
}

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (nonatomic) UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;



@end
