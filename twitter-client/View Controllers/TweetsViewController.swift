//
//  TwetsViewController.swift
//  twitter-client
//
//  Created by Paul Sokolik on 9/29/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var initialLoad: Bool = false
    var isMoreDataLoading: Bool = false
    var loadingMoreView: InfiniteScrollActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        let twitterBlue = UIColor(displayP3Red: CGFloat(0)/255, green: CGFloat(172)/255, blue: CGFloat(237)/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = twitterBlue
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        initInfiniteScroll()
        
        // refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        // fetch tweets
        TwitterClient.sharedInstance.homeTimeline(loadMore: false, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.initialLoad = true
            self.tableView.reloadData()
        }) { (error: Error) in
            print("Error: \(error.localizedDescription)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // only reset tweets collection if view has already been fetched initally
        if (initialLoad) {
            tweets = Tweet.tweets
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                loadingMoreView!.startAnimating()
                
                // fetch MOAR tweets
                TwitterClient.sharedInstance.homeTimeline(loadMore: true, success: { (tweets: [Tweet]) in
                    self.tweets = Tweet.tweets
                    self.loadingMoreView!.stopAnimating()
                    self.tableView.reloadData()
                    self.isMoreDataLoading = false
                }) { (error: Error) in
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TweetDetailSegue" {
            let detailsViewController = segue.destination as! DetailViewController
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPath(for: cell)
            detailsViewController.tweet = tweets[indexPath!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func initInfiniteScroll() {
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.tableFooterView = loadingMoreView
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeline(loadMore: false, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            refreshControl.endRefreshing()
            self.tableView.reloadData()
        }) { (error: Error) in
            print("Error getting timeline")
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
}
