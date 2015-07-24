

#import "ThirdViewController.h"

@interface ThirdViewController ()


@end

@implementation ThirdViewController

//print out
@synthesize username;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = [UIImage imageNamed:@"bg4"];
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundImageView.layer.zPosition = -1;
    [self.view addSubview:backgroundImageView];
    
    //jenny add
    NSMutableString *str;
    
    str = [[NSMutableString alloc] init];
    
   /* PFQuery *query = [PFQuery queryWithClassName:@"HiRoomi"];
    [query getObjectInBackgroundWithId:@"Sj9v1SxpTq" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", gameScore);
    }];*/
    
    
    //PFQuery *query = [PFQuery queryWithClassName:@"HiRoomi"]; //1
    PFUser *user = [PFUser currentUser];
    NSLog(@"%@", user.username);
    username.text = user.username;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
