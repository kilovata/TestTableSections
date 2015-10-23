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
@property (strong, nonatomic) NSMutableArray *arrayItemsInsert;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddSection;
@property (weak, nonatomic) IBOutlet UIButton *buttonRemoveSection;
@property (weak, nonatomic) IBOutlet UIButton *buttonChangeAnimation;
@property (assign, nonatomic) UITableViewRowAnimation typeAnimation;

- (IBAction)addSection:(id)sender;
- (IBAction)removeSection:(id)sender;
- (IBAction)changeAnimation:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.arrayItems = [NSMutableArray array];
	for (int i=0; i<10; i++)
	{
		NSString *str = [NSString stringWithFormat:@"Section %i", i];
		[self.arrayItems addObject:str];
	}
	
	self.arrayItemsInsert = [NSMutableArray array];
	for (int i=0; i<3; i++)
	{
		NSString *str = [NSString stringWithFormat:@"New Section %i", i];
		[self.arrayItemsInsert addObject:str];
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
	if (self.arrayItems.count > self.arrayItemsInsert.count)
	{
		NSInteger index = 1;
		[self.table beginUpdates];
		NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(index, self.arrayItemsInsert.count)];
		[self.arrayItems removeObjectsAtIndexes:indexSet];
		[self.table deleteSections:indexSet withRowAnimation:self.typeAnimation];
		[self.table endUpdates];
	}
	else
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
}

- (IBAction)addSection:(id)sender
{
	NSInteger index = 1;
	if (self.arrayItems.count == 0)
	{
		index = 0;
	}
	self.buttonRemoveSection.enabled = YES;
	[self.table beginUpdates];
	NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(index, self.arrayItemsInsert.count)];
	[self.arrayItems insertObjects:self.arrayItemsInsert atIndexes:indexSet];
	[self.table insertSections:indexSet withRowAnimation:self.typeAnimation];
	[self.table endUpdates];
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

@end
