# Project 4 - *Twitter Redux*

Time spent: **17** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] Hamburger menu
   - [X] Dragging anywhere in the view should reveal the menu.
   - [X] The menu should include links to your profile, the home timeline, and the mentions view.
   - [X] The menu can look similar to the example or feel free to take liberty with the UI.
- [X] Profile page
   - [X] Contains the user header view
   - [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [X] Home Timeline
   - [X] Tapping on a user image should bring up that user's profile page

The following **optional** features are implemented:

- [ ] Profile Page
   - [ ] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account


The following **additional** features are implemented:

- [X] Auto-adjusting constraints on the details page depending on whether the delete button is displayed
- [X] Lots of code cleanup!
- [X] Global nav styles
- [X] Reusable xib tweet cell
- [X] Better UI for creating tweets (updated placeholder logic)
- [X] Improved hamburger/menu view controller invocation pattern (no dependency on order in app delegate)
- [X] Disallow dragging of content view outside of display view
- [X] Better login screen UI

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

  1. Anyone find any better patterns for invoking haburger and menu view controllers?
  2. How did you prevent the menu view from responding to the drag gesture? It needed to have "user interactin enabled" so that the tableView was clickable, but we didn't want it to drag when touched.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://preview.ibb.co/ktdXgG/twitter_redux.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2017] [Paul Sokolik]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
