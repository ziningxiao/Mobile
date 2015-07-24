

#import "FirstViewController.h"
#import <Parse/Parse.h>


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = [UIImage imageNamed:@"bg4"];
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundImageView.layer.zPosition = -1;
    [self.view addSubview:backgroundImageView];
}

-(void)viewDidAppear:(BOOL)animated{
    
    if(![PFUser currentUser]){
    
        [self.tabBarController performSegueWithIdentifier:@"loginView" sender:nil];
    
    }

}

-(IBAction)userStartedSession:(UIStoryboardSegue *)sender{
    NSLog(@"Loged in");

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
