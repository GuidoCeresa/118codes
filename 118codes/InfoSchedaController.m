//
//  InfoSchedaController.m
//  118codes
//
//  Created by Guido Ceresa on 16-12-12.
//  Copyright (c) 2012 Alessandro Valbonesi. All rights reserved.
//  Deprecata

#import "InfoSchedaController.h"
#import "UIBorderLabel.h"

@interface InfoSchedaController ()

@end

@implementation InfoSchedaController

#pragma mark - Synthesize Variables
@synthesize nomeInfoFile;
@synthesize nomeSegue;
@synthesize web;
@synthesize activityIndicator;

//--testo da visualizzare
NSString *testo;

//--scroll view
UIScrollView *scrollView;

//--colori di sfondo delle label
UIColor *grigioCeleste;

//--posizionamento delle varie righe
int righe;
int caratteriPerOgniRiga = 36;
int altezzaRiga = 24;

#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--recupera la pagina web
    if (nomeInfoFile) {
        [self setUpWeb];
    }
    
    
	// Do any additional setup after loading the view.
    
    //--di norma metto sempre lo stesso nome (ma volendo si può cambiare)--
    nomeSegue = @"infoscheda";
    
    //--inserimento della vista scorrevole
    //[self insertScroll];
    
    //--sfondo
    //--colore di sfondo della finestra--
    grigioCeleste = [UIColor colorWithRed: 240.0/255.0 green: 245.0/255.0 blue:245.0/255.0 alpha: 1.0];
    [self.view setBackgroundColor:grigioCeleste];
    
    //--recupera il testo dal file
    //[self setUptesto];
    
    //--disegna il testo nella label
    //    [self disegnaTesto];
}

//--recupera la pagina web
- (void)setUpWeb {
    //nomeInfoFile = @"asa";
    NSString *domain = @"http://www.algos.it/118/file/";
    domain = [domain stringByAppendingString:nomeInfoFile];
    domain = [domain stringByAppendingString:@".html"];
    NSURL *url = [NSURL URLWithString:domain];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [web loadRequest:requestURL];
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:requestURL];
}


//--recupera il testo dal file
- (void)setUptesto {
    if ([nomeInfoFile length] > 0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:nomeInfoFile ofType:@"txt"];
        if (filePath) {
            NSError *error;
            NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
            if (myText) {
                testo= myText;
            } else {
                testo= @"";
            }
        } else {
            testo= @"";
        }
    } else {
        testo= @"";
    }
}

//--inserimento della vista scorrevole
- (void)insertScroll {
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.contentSize = CGSizeMake(320, 800);
    scrollView.clipsToBounds = YES;
    scrollView.bounces = YES; //--rimbalza
    super.view.backgroundColor = grigioCeleste;
    [scrollView setUserInteractionEnabled:YES];
    [self.view addSubview:scrollView];
}

//--disegna il testo nella label
- (void)disegnaTesto {
    int righe;
    righe = [testo length]/caratteriPerOgniRiga;
    righe++;
    
    CGRect labelFrame = CGRectMake( 0, 0, 320, righe*altezzaRiga);
    UIBorderLabel* label = [[UIBorderLabel alloc] initWithFrame:labelFrame];
    label.leftInset = 10;
    label.rightInset = 10;
    [label setFont:[UIFont systemFontOfSize:17]];
    label.numberOfLines = righe;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label setText:testo];
    [label setBackgroundColor:grigioCeleste];
    [scrollView addSubview: label];
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	//CAPTURE USER LINK-CLICK.
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		NSURL *URL = [request URL];
		if ([[URL scheme] isEqualToString:@"http"]) {
		}
		return NO;
	}
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[activityIndicator stopAnimating];
}


#pragma mark - View Edit
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"infoscheda"]) {
        InfoSchedaController *destViewController = segue.destinationViewController;
        destViewController.nomeInfoFile= nomeInfoFile;
    }
}


//--bottone info nella barra di navigazione--
- (IBAction)setInfo:(id)sender {
    NSString *identifier = nomeSegue;
    
    @try {
        [self performSegueWithIdentifier:identifier sender:self];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

@end
