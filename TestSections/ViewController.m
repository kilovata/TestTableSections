//
//  ViewController.m
//  TestSections
//
//  Created by Полищук Светлана on 22/10/15.
//  Copyright © 2015 Polishchuk Svetlana. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *arrayItems;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddSection;
@property (weak, nonatomic) IBOutlet UIButton *buttonRemoveSection;
@property (weak, nonatomic) IBOutlet UIButton *buttonChangeAnimation;
@property (assign, nonatomic) UITableViewRowAnimation typeAnimation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewBottomHeight;
@property (assign, nonatomic) NSInteger newSection;
@property (assign, nonatomic) BOOL isAddItem;
@property (assign, nonatomic) CGPoint pointStopScroll;

- (IBAction)addSection:(id)sender;
- (IBAction)removeSection:(id)sender;
- (IBAction)changeAnimation:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.newSection = 0;
	self.isAddItem = NO;
	
	self.arrayItems = [NSMutableArray array];
	for (int i=0; i<10; i++)
	{
		NSString *str = [NSString stringWithFormat:@"Section %i", i];
		[self.arrayItems addObject:str];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.arrayItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	NSString *str = self.arrayItems[indexPath.section];
	cell.textLabel.text = str;
	return cell;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (IBAction)removeSection:(id)sender
{
	if (self.arrayItems.count > 0)
	{
		NSInteger index = 1;
		if (self.arrayItems.count == 1)
		{
			index = 0;
			self.buttonRemoveSection.enabled = NO;
		}
		[self.table beginUpdates];
		[self.arrayItems removeObjectAtIndex:index];
		NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
		[self.table deleteSections:indexSet withRowAnimation:self.typeAnimation];
		[self.table endUpdates];
	}
}

- (IBAction)addSection:(id)sender
{
	self.isAddItem = YES;
	NSInteger index = 0;
	if (self.arrayItems.count == 0)
	{
		index = 0;
	}
	self.buttonRemoveSection.enabled = YES;
	[self.table beginUpdates];
	[UIView setAnimationsEnabled:NO];
	self.newSection = self.arrayItems.count + 1;
	NSString *str = [NSString stringWithFormat:@"New section %lu", self.newSection];
	[self.arrayItems insertObject:str atIndex:index];
	NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
	[self.table insertSections:indexSet withRowAnimation:self.typeAnimation];
	[self.table endUpdates];
	
	self.pointStopScroll = CGPointMake(0, self.pointStopScroll.y + 44.f);
	[self.table setContentOffset:self.pointStopScroll];
	
	[UIView setAnimationsEnabled:YES];
}

- (IBAction)changeAnimation:(id)sender
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationFade" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationFade;
		[self.buttonChangeAnimation setTitle:@"Fade" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationRight" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationRight;
		[self.buttonChangeAnimation setTitle:@"Right" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationLeft" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationLeft;
		[self.buttonChangeAnimation setTitle:@"Left" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationTop" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationTop;
		[self.buttonChangeAnimation setTitle:@"Top" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationBottom" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationBottom;
		[self.buttonChangeAnimation setTitle:@"Bottom" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationNone" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationNone;
		[self.buttonChangeAnimation setTitle:@"None" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationMiddle" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationMiddle;
		[self.buttonChangeAnimation setTitle:@"Middle" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"UITableViewRowAnimationAutomatic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.typeAnimation = UITableViewRowAnimationAutomatic;
		[self.buttonChangeAnimation setTitle:@"Automatic" forState:UIControlStateNormal];
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (self.isAddItem && scrollView.contentOffset.y != self.pointStopScroll.y)
	{
		[self.table setContentOffset:self.pointStopScroll];
		self.isAddItem = NO;
	}
}

@end
