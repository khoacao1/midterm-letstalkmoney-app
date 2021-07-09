import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:letstalkmoney_app/ad_helper.dart';
import 'package:letstalkmoney_app/screens/pages/businesschat.dart';
import 'package:letstalkmoney_app/screens/pages/gamechat.dart';
import 'package:letstalkmoney_app/screens/pages/health.dart';
import 'package:letstalkmoney_app/screens/pages/study.dart';

// class GroupList extends StatelessWidget {
//   const GroupList({Key? key}) : super(key: key);
class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  // TODO: Add _bannerAd
  late BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;

  // TODO: Add _rewardedAd
  late RewardedAd _rewardedAd;

  // TODO: Add _isRewardedAdReady
  bool _isRewardedAdReady = false;

  @override
  void initState() {
    super.initState();

    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();

    _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    _loadInterstitialAd();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // child: ListView(
          // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Color(0xFF2a9d8f),
                      )),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 35.0),
                      dense: true,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => GameChatPage()));
                      },
                      leading: Image.asset(
                        'assets/groupicons/games.jpg',
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Games',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2a9d8f),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Color(0xFF2a9d8f),
                      )),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 35.0),
                      dense: true,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BusinessChatPage()));
                      },
                      leading: Image.asset(
                        'assets/groupicons/business.jpg',
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Business',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2a9d8f),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Color(0xFF2a9d8f),
                      )),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 35.0),
                      dense: true,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HealthChatPage()));
                      },
                      leading: Image.asset(
                        'assets/groupicons/healthcare.jpg',
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Public Health',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2a9d8f),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Color(0xFF2a9d8f),
                      )),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 35.0),
                      dense: true,
                      onTap: () {
                        // _loadInterstitialAd();
                        // TODO: Display an Interstitial Ad
                        if (_isInterstitialAdReady) {
                          _interstitialAd?.show();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => StudyChatPage()));
                        } else {
                          StudyChatPage();
                        }
                      },
                      leading: Image.asset(
                        'assets/groupicons/study.jpg',
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Study',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2a9d8f),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ],
          // ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget? _buildFloatingActionButton() {
    // TODO: Return a FloatingActionButton if a Rewarded Ad is available
    return (_isRewardedAdReady)
        ? FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Want reward?'),
                    content: Text('Watch an Ad to get reward!'),
                    actions: [
                      TextButton(
                        child: Text('cancel'.toUpperCase()),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('ok'.toUpperCase()),
                        onPressed: () {
                          Navigator.pop(context);
                          _rewardedAd.show(onUserEarnedReward: (_, reward) {});
                        },
                      ),
                    ],
                  );
                },
              );
            },
            label: Text('Reward Ads'),
            icon: Icon(Icons.card_giftcard),
            backgroundColor: Color(0xFF2a9d8f),
          )
        : null;
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();

    // TODO: Dispose an InterstitialAd object
    _interstitialAd?.dispose();

    // TODO: Dispose a RewardedAd object
    _rewardedAd.dispose();

    super.dispose();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              StudyChatPage();
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }
}
