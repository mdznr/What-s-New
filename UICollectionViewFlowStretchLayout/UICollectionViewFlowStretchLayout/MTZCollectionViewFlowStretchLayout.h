//
//  MTZCollectionViewFlowStretchLayout.h
//  UICollectionViewFlowStretchLayout
//
//  Created by Matt Zanchelli on 5/29/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTZCollectionViewDelegateFlowStretchLayout <NSObject>


#pragma mark - Getting the Size of Items

///	Asks the delegate for the minimum size of the specified item’s cell.
///	@param collectionView The collection view object displaying the flow layout.
///	@param collectionViewLayout The layout object requesting the information.
///	@param indexPath The index path of the item.
///	@return The minimum width and minimum height of the specified item. Both values must be greater than 0.
/// @discussion If you do not implement this method, the flow layout uses the values in its @c itemSize property to set the size of items instead. Your implementation of this method can return a fixed set of sizes or dynamically adjust the sizes based on the cell’s content.
///	@discussion The flow layout does not crop a cell’s bounds to make it fit into the grid. Therefore, the values you return must allow for the item to be displayed fully in the collection view. For example, in a vertically scrolling grid, the width of a single item must not exceed the width of the collection view view (minus any section insets) itself. However, in the scrolling direction, items can be larger than the collection view because the remaining content can always be scrolled into view.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumSizeForItemAtIndexPath:(NSIndexPath *)indexPath;


#pragma mark - Getting the Section Spacing

///	Asks the delegate for the margins to apply to content in the specified section.
///	@param collectionView The collection view object displaying the flow layout.
///	@param collectionViewLayout The layout object requesting the information.
///	@param section The index number of the section whose insets are needed.
///	@return The margins to apply to items in the section.
/// @discussion If you do not implement this method, the flow layout uses the value in its @c sectionInset property to set the margins instead. Your implementation of this method can return a fixed set of margin sizes or return different margin sizes for each section.
/// @discussion Section insets are margins applied only to the items in the section. They represent the distance between the header view and the first line of items and between the last line of items and the footer view. They also indicate they spacing on either side of a single line of items. They do not affect the size of the headers or footers themselves.
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

///	Asks the delegate for the margins to apply to content in the specified section.
///	@param collectionView The collection view object displaying the flow layout.
///	@param collectionViewLayout The layout object requesting the information.
///	@param section The index number of the section whose insets are needed.
///	@return The minimum space (measured in points) to apply between successive lines in a section.
/// @discussion If you do not implement this method, the flow layout uses the value in its @c minimumLineSpacing property to set the space between lines instead. Your implementation of this method can return a fixed value or return different spacing values for each section.
/// @discussion For a vertically scrolling grid, this value represents the minimum spacing between successive rows. For a horizontally scrolling grid, this value represents the minimum spacing between successive columns. This spacing is not applied to the space between the header and the first line or between the last line and the footer.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

/// Asks the delegate for the spacing between successive items in the rows or columns of a section.
///	@param collectionView The collection view object displaying the flow layout.
///	@param collectionViewLayout The layout object requesting the information.
///	@param section The index number of the section whose insets are needed.
/// @return The minimum space (measured in points) to apply between successive items in the lines of a section.
/// @discussion If you do not implement this method, the flow layout uses the value in its @c minimumInteritemSpacing property to set the space between items instead. Your implementation of this method can return a fixed value or return different spacing values for each section.
///	@discussion For a vertically scrolling grid, this value represents the minimum spacing between items in the same row. For a horizontally scrolling grid, this value represents the minimum spacing between items in the same column. This spacing is used to compute how many items can fit in a single line, but after the number of items is determined, the actual spacing may possibly be adjusted upward.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;


#pragma mark - Getting Header and Footer Sizes

///	Asks the delegate for the size of the header view in the specified section.
///	@param collectionView The collection view object displaying the flow layout.
///	@param collectionViewLayout The layout object requesting the information.
///	@param section The index number of the section whose insets are needed.
///	@return The size of the header. If you return a value of size @c CGSizeZero, no header is added.
/// @discussion If you do not implement this method, the flow layout uses the value in its @c headerReferenceSize property to set the size of the header.
///	@discussion During layout, only the size that corresponds to the appropriate scrolling direction is used. For example, for the vertical scrolling direction, the layout object uses the height value returned by your method. (In that instance, the width of the header would be set to the width of the collection view.) If the size in the appropriate scrolling dimension is 0, no header is added.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

///	Asks the delegate for the size of the footer view in the specified section.
///	@param collectionView The collection view object displaying the flow layout.
///	@param collectionViewLayout The layout object requesting the information.
///	@param section The index number of the section whose insets are needed.
///	@return The size of the footer. If you return a value of size @c CGSizeZero, no footer is added.
/// @discussion If you do not implement this method, the flow layout uses the value in its @c footerReferenceSize property to set the size of the footer.
/// @discussion During layout, only the size that corresponds to the appropriate scrolling direction is used. For example, for the vertical scrolling direction, the layout object uses the height value specified by this property. (In that instance, the width of the footer would be set to the width of the collection view.) If the size in the appropriate scrolling dimension is 0, no footer is added.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end


@interface MTZCollectionViewFlowStretchLayout : UICollectionViewLayout

#pragma mark - Configuring the Scroll Direction

///	The scroll direction of the grid.
/// @discussion The grid layout scrolls along one axis only, either horizontally or vertically. For the non scrolling axis, the width of the collection view in that dimension serves as starting width of the content.
///	@discussion The default value of this property is @c UICollectionViewScrollDirectionVertical.
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;


#pragma mark - Configuring the Item Spacing

///	The minimum spacing to use between lines of items in the grid.
///	@discussion If the delegate object does not implement the @c collectionView:layout:minimumLineSpacingForSectionAtIndex: method, the flow layout uses the value in this property to set the spacing between lines in a section.
/// @discussion For a vertically scrolling grid, this value represents the minimum spacing between successive rows. For a horizontally scrolling grid, this value represents the minimum spacing between successive columns. This spacing is not applied to the space between the header and the first line or between the last line and the footer.
/// @discussion The default value of this property is 10.0.
@property (nonatomic) CGFloat minimumLineSpacing;

/// The minimum spacing to use between items in the same row.
///	@discussion If the delegate object does not implement the @c collectionView:layout:minimumInteritemSpacingForSectionAtIndex: method, the flow layout uses the value in this property to set the spacing between items in the same line.
///	@discussion For a vertically scrolling grid, this value represents the minimum spacing between items in the same row. For a horizontally scrolling grid, this value represents the minimum spacing between items in the same column. This spacing is used to compute how many items can fit in a single line, but after the number of items is determined, the actual spacing may possibly be adjusted upward.
///	@discussion The default value of this property is 10.0.
@property (nonatomic) CGFloat minimumInteritemSpacing;

/// The default size to use for cells.
///	@discussion If the delegate does not implement the @c collectionView:layout:sizeForItemAtIndexPath: method, the flow layout uses the value in this property to set the size of each cell. This results in cells that all have the same size.
///	@discussion The default size value is (50.0, 50.0).
@property (nonatomic) CGSize itemSize;

/// The margins used to lay out content in a section
///	@discussion If the delegate object does not implement the @c collectionView:layout:insetForSectionAtIndex: method, the flow layout uses the value in this property to set the margins for each section.
///	@discussion Section insets reflect the spacing at the outer edges of the section. The margins affect the initial position of the header view, the minimum space on either side of each line of items, and the distance from the last line to the footer view. The margin insets do not affect the size of the header and footer views in the non scrolling direction.
///	@discussion The default edge insets are all set to 0.
@property (nonatomic) UIEdgeInsets sectionInset;


#pragma mark - Configuring the Supplementary Views

/// The default sizes to use for section headers.
///	@discussion If the delegate does not implement the @c collectionView:layout:referenceSizeForHeaderInSection: method, the flow layout object uses the default header sizes set in this property.
///	@discussion During layout, only the size that corresponds to the appropriate scrolling direction is used. For example, for the vertical scrolling direction, the layout object uses the height value returned by your method. (In that instance, the width of the header would be set to the width of the collection view.) If the size in the appropriate scrolling dimension is 0, no header is added.
///	@discussion The default size values are (0, 0).
@property (nonatomic) CGSize headerReferenceSize;

/// The default sizes to use for section footers.
///	@discussion If the delegate does not implement the @c collectionView:layout:referenceSizeForFooterInSection: method, the flow layout object uses the default footer sizes set for this property.
///	@discussion During layout, only the size that corresponds to the appropriate scrolling direction is used. For example, for the vertical scrolling direction, the layout object uses the height value specified by this property. (In that instance, the width of the footer would be set to the width of the collection view.) If the size in the appropriate scrolling dimension is 0, no footer is added.
///	@discussion The default size values are (0, 0).
@property (nonatomic) CGSize footerReferenceSize;

@end
