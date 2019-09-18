//
//  UISearchBar+ZBlocks.m
//  Pods
//
//  Created by zwx on 2017/11/22.
//

#import "UISearchBar+ZBlocks.h"
#import <objc/runtime.h>

/* Only for convenience and readabilty in delegate methods */
typedef BOOL (^z_UISearchBarReturnBlock) (UISearchBar *searchBar);
typedef void (^z_UISearchBarVoidBlock) (UISearchBar *searchBar);
typedef void (^z_UISearchBarSearchTextBlock) (UISearchBar *searchBar,NSString *searchText);
typedef BOOL (^z_UISearchBarInRangeReplacementTextBlock) (UISearchBar *searchBar,NSRange range,NSString *text);
typedef void (^z_UISearchBarScopeIndexBlock)(UISearchBar *searchBar, NSInteger selectedScope);

@implementation UISearchBar (ZBlocks)


static const void *z_UISearchBarDelegateKey                                = &z_UISearchBarDelegateKey;
static const void *z_UISearchBarShouldBeginEditingKey                      = &z_UISearchBarShouldBeginEditingKey;
static const void *z_UISearchBarTextDidBeginEditingKey                     = &z_UISearchBarTextDidBeginEditingKey;
static const void *z_UISearchBarShouldEndEditingKey                        = &z_UISearchBarShouldEndEditingKey;
static const void *z_UISearchBarTextDidEndEditingKey                       = &z_UISearchBarTextDidEndEditingKey;
static const void *z_UISearchBarTextDidChangeKey                           = &z_UISearchBarTextDidChangeKey;
static const void *z_UISearchBarShouldChangeTextInRangeKey                 = &z_UISearchBarShouldChangeTextInRangeKey;
static const void *z_UISearchBarSearchButtonClickedKey                                = &z_UISearchBarSearchButtonClickedKey;
static const void *z_UISearchBarBookmarkButtonClickedKey                                = &z_UISearchBarBookmarkButtonClickedKey;
static const void *z_UISearchBarCancelButtonClickedKey                                = &z_UISearchBarCancelButtonClickedKey;
static const void *z_UISearchBarResultsListButtonClickedKey                                = &z_UISearchBarResultsListButtonClickedKey;
static const void *z_UISearchBarSelectedScopeButtonIndexDidChangeKey                                = &z_UISearchBarSelectedScopeButtonIndexDidChangeKey;




#pragma mark UISearchBar delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    z_UISearchBarReturnBlock block = searchBar.z_completionShouldBeginEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]){
        return [delegate searchBarShouldBeginEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    z_UISearchBarVoidBlock block = searchBar.z_completionTextDidBeginEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    z_UISearchBarReturnBlock block = searchBar.z_completionShouldEndEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        return [delegate searchBarShouldEndEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    z_UISearchBarVoidBlock block = searchBar.z_completionTextDidEndEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    z_UISearchBarSearchTextBlock block = searchBar.z_completionTextDidChangeBlock;
    if (block) {
        block(searchBar,searchText);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textDidChange:)]){
        [delegate searchBar:searchBar textDidChange:searchText];
    }
}
// called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    z_UISearchBarInRangeReplacementTextBlock block = searchBar.z_completionShouldChangeTextInRangeBlock;
    if (block) {
        return block(searchBar,range,text);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]){
        return [delegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    z_UISearchBarVoidBlock block = searchBar.z_completionSearchButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [delegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    z_UISearchBarVoidBlock block = searchBar.z_completionBookmarkButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]){
        [delegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    z_UISearchBarVoidBlock block = searchBar.z_completionCancelButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]){
        [delegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    z_UISearchBarVoidBlock block = searchBar.z_completionResultsListButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]){
        [delegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    z_UISearchBarScopeIndexBlock block = searchBar.z_completionSelectedScopeButtonIndexDidChangeBlock;
    if (block) {
        block(searchBar,selectedScope);
    }
    id delegate = objc_getAssociatedObject(self, z_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]){
        [delegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}


#pragma mark Block setting/getting methods
- (BOOL (^)(UISearchBar *))z_completionShouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarShouldBeginEditingKey);
}

- (void)setZ_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldBeginEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarShouldBeginEditingKey, searchBarShouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))z_completionTextDidBeginEditingBlock
{
    return objc_getAssociatedObject(self,z_UISearchBarTextDidBeginEditingKey);
}

- (void)setZ_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *))searchBarTextDidBeginEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarTextDidBeginEditingKey, searchBarTextDidBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *))z_completionShouldEndEditingBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarShouldEndEditingKey);
}

- (void)setZ_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldEndEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarShouldEndEditingKey, searchBarShouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))z_completionTextDidEndEditingBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarTextDidEndEditingKey);
}

- (void)setZ_completionTextDidEndEditingBlock:(void (^)(UISearchBar *))searchBarTextDidEndEditingBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarTextDidEndEditingKey, searchBarTextDidEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSString *))z_completionTextDidChangeBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarTextDidChangeKey);
}

- (void)setZ_completionTextDidChangeBlock:(void (^)(UISearchBar *, NSString *))searchBarTextDidChangeBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarTextDidChangeKey, searchBarTextDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *, NSRange, NSString *))z_completionShouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarShouldChangeTextInRangeKey);
}

- (void)setZ_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *, NSRange, NSString *))searchBarShouldChangeTextInRangeBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarShouldChangeTextInRangeKey, searchBarShouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))z_completionSearchButtonClickedBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarSearchButtonClickedKey);
}

- (void)setZ_completionSearchButtonClickedBlock:(void (^)(UISearchBar *))searchBarSearchButtonClickedBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarSearchButtonClickedKey, searchBarSearchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))z_completionBookmarkButtonClickedBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarBookmarkButtonClickedKey);
}

- (void)setZ_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *))searchBarBookmarkButtonClickedBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarBookmarkButtonClickedKey, searchBarBookmarkButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))z_completionCancelButtonClickedBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarCancelButtonClickedKey);
}

- (void)setZ_completionCancelButtonClickedBlock:(void (^)(UISearchBar *))searchBarCancelButtonClickedBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarCancelButtonClickedKey, searchBarCancelButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))z_completionResultsListButtonClickedBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarResultsListButtonClickedKey);
}

- (void)setZ_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *))searchBarResultsListButtonClickedBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarResultsListButtonClickedKey, searchBarResultsListButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSInteger))z_completionSelectedScopeButtonIndexDidChangeBlock
{
    return objc_getAssociatedObject(self, z_UISearchBarSelectedScopeButtonIndexDidChangeKey);
}

- (void)setZ_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *, NSInteger))searchBarSelectedScopeButtonIndexDidChangeBlock
{
    [self z_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, z_UISearchBarSelectedScopeButtonIndexDidChangeKey, searchBarSelectedScopeButtonIndexDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void)z_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UISearchBarDelegate>)self) {
        objc_setAssociatedObject(self, z_UISearchBarDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UISearchBarDelegate>)self;
    }
}

@end
