/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2012, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation and/or
   other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


#import "JRBooks.h"

@implementation JRBooks
{
    NSInteger _booksId;
    NSString *_book;
}
@dynamic booksId;
@dynamic book;

- (NSInteger)booksId
{
    return _booksId;
}

- (void)setBooksId:(NSInteger)newBooksId
{
    [self.dirtyPropertySet addObject:@"booksId"];

    _booksId = newBooksId;
}

- (NSString *)book
{
    return _book;
}

- (void)setBook:(NSString *)newBook
{
    [self.dirtyPropertySet addObject:@"book"];

    if (!newBook)
        _book = [NSNull null];
    else
        _book = [newBook copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/profiles/profile/books";
    }
    return self;
}

+ (id)books
{
    return [[[JRBooks alloc] init] autorelease];
}

- (id)copyWithZone:(NSZone*)zone
{
    JRBooks *booksCopy =
                [[JRBooks allocWithZone:zone] init];

    booksCopy.booksId = self.booksId;
    booksCopy.book = self.book;

    return booksCopy;
}

+ (id)booksObjectFromDictionary:(NSDictionary*)dictionary
{
    JRBooks *books =
        [JRBooks books];

    books.booksId = [(NSNumber*)[dictionary objectForKey:@"id"] intValue];
    books.book = [dictionary objectForKey:@"book"];

    return books;
}

- (NSDictionary*)dictionaryFromBooksObject
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    if (self.booksId)
        [dict setObject:[NSNumber numberWithInt:self.booksId] forKey:@"id"];

    if (self.book && self.book != [NSNull null])
        [dict setObject:self.book forKey:@"book"];
    else
        [dict setObject:[NSNull null] forKey:@"book"];

    return dict;
}

- (void)updateLocallyFromNewDictionary:(NSDictionary*)dictionary
{
    if ([dictionary objectForKey:@"id"])
        _booksId = [(NSNumber*)[dictionary objectForKey:@"id"] intValue];

    if ([dictionary objectForKey:@"book"])
        _book = [dictionary objectForKey:@"book"];
}

- (void)replaceLocallyFromNewDictionary:(NSDictionary*)dictionary
{
    _booksId = [(NSNumber*)[dictionary objectForKey:@"id"] intValue];
    _book = [dictionary objectForKey:@"book"];
}

- (void)updateObjectOnCaptureForDelegate:(id<JRCaptureObjectDelegate>)delegate withContext:(NSObject *)context
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"booksId"])
        [dict setObject:[NSNumber numberWithInt:self.booksId] forKey:@"id"];

    if ([self.dirtyPropertySet containsObject:@"book"])
        [dict setObject:self.book forKey:@"book"];

    NSDictionary *newContext = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     self, @"captureObject",
                                                     delegate, @"delegate",
                                                     context, @"callerContext", nil];

    [JRCaptureInterface updateCaptureObject:dict
                                     withId:0
                                     atPath:self.captureObjectPath
                                  withToken:[JRCaptureData accessToken]
                                forDelegate:self
                                withContext:newContext];
}

- (void)replaceObjectOnCaptureForDelegate:(id<JRCaptureObjectDelegate>)delegate withContext:(NSObject *)context
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:[NSNumber numberWithInt:self.booksId] forKey:@"id"];
    [dict setObject:self.book forKey:@"book"];

    NSDictionary *newContext = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     self, @"captureObject",
                                                     delegate, @"delegate",
                                                     context, @"callerContext", nil];

    [JRCaptureInterface replaceCaptureObject:dict
                                      withId:0
                                      atPath:self.captureObjectPath
                                   withToken:[JRCaptureData accessToken]
                                 forDelegate:self
                                 withContext:newContext];
}

- (void)dealloc
{
    [_book release];

    [super dealloc];
}
@end