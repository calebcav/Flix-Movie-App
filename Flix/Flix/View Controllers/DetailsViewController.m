//
//  DetailsViewController.m
//  Flix
//
//  Created by Caleb Caviness on 6/24/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "DetailsViewController.h"
#import <UIImageView+AFNetworking.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, strong) NSArray *similarMovies;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingFormat:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingFormat:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    [self fetchSimilarMovies];
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    // Do any additional setup after loading the view.
}

- (void) fetchSimilarMovies {
//[self.activityIndicator startAnimating];
    
NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/508439/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (error != nil) {
           NSLog(@"%@", [error localizedDescription]);
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                  message:@"The internet connection appears to be offline"
           preferredStyle:(UIAlertControllerStyleAlert)];

           // create a cancel action
           UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                    // handle cancel response here. Doing nothing will dismiss the view.
                                                             }];
           // add the cancel action to the alertController
           [alert addAction:cancelAction];

           // create an OK action
           UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                    // handle response here.
                                                            }];
           // add the OK action to the alert controller
           [alert addAction:okAction];
           [self presentViewController:alert animated:YES completion:^{
               // optional code for what happens after the alert controller has finished presenting
           }];
       }
       else {
           NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           
           NSInteger movieID = self.movie[@"id"];
           NSLog(@"%tu", movieID);
           //[self.collectionView reloadData];
           
           
           // TODO: Get the array of movies
           // TODO: Store the movies in a property to use elsewhere
           // TODO: Reload your table view data
       }
    //[self.refreshControl endRefreshing];
    //[self.activityIndicator stopAnimating];
   }];
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
