

#import <UIKit/UIKit.h>

@interface UserSignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *mailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)cancelPressed:(UIButton *)sender;
- (IBAction)signupPressed:(UIButton *)sender;

@end
