passably-connected
==================

passably-connected is a boilerplate for Apple's Multipeer Connectivity framework.

It abstracts away some of the weird parts of the multipeer connectivity
framework to get make it easy to use and keep your code clean. Each
wrapper class implements the viewcontroller as a delegate and
the ViewController implements each of those delegates and
their protocol methods.

This may seem a little redundant, "why wouldn't I just implement the Multi Peer
framework in my ViewController Directly?" It's messy and a pain to maintain.
This boilerplate makes it very clear to see what's happening at each point
and makes the framework useable without having to debug everything.

`If for some reason you don't understand any of this stuff:` I recommend learning about
delegates and delegate methods. They are pretty cool. The methods in the
ViewController.m file get automatically triggered when something
happens. For example when we find a peer 'inviteFoundPeer'
gets triggered. Delegates trigger stuff magically.

Friendly Reminder: Make sure both your bluetooth and wifi card are
active on yourdevice!

Usage
=====
All you have to do to use it to start your project is take the files in the
passably-connected folder and drop them into your app. If you dont want
to use the ViewController files, then just look at how the other
files interact with it and replicate that logic in your own
file. It's a plain-jane delegate method implementation.

Future
======
Maybe this will become a static library? This current format just felt more
accessible.

As always if you have any questions or just wana chat about some obscure art project,
hit me up on twitter <a href="https://twitter.com/yvanscher">@yvanscher</a>.
