

#import "UserSignupViewController.h"
#import <Parse/Parse.h>

@interface UserSignupViewController ()

@end

@implementation UserSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = [UIImage imageNamed:@"bg2"];
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundImageView.layer.zPosition = -1;
    [self.view addSubview:backgroundImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma - mark IBActions

- (IBAction)cancelPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signupPressed:(UIButton *)sender {
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.tintColor = [UIColor blackColor];
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
    PFUser *newUser = [PFUser user];
    newUser.username = self.nameField.text;
    newUser.email = self.mailField.text;
    newUser.password = self.passwordField.text;
    newUser[@"fullName"] = self.nameField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeed, NSError *error){
        
        [indicator stopAnimating];
        [indicator removeFromSuperview];
    
        if(succeed){
            NSLog(@"signed up");
            [newUser saveEventually];
            [self performSegueWithIdentifier:@"logIn" sender:nil];
        
        }
        else {
        
            if([UIAlertController class]){//UIAlertController for iOS 8
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Signup. Try again." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancel];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Signup. Try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
            }

        
        }
    
    
    }];
    
}

@end
