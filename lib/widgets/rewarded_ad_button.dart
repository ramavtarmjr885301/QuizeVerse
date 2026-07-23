import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/ad_service.dart';

class RewardedAdButton extends StatefulWidget {
  const RewardedAdButton({super.key});

  @override
  State<RewardedAdButton> createState() => _RewardedAdButtonState();
}

class _RewardedAdButtonState extends State<RewardedAdButton> {
  static const int _rewardCoins = 20;
  bool _isLoadingOnTap = false;

  @override
  void initState() {
    super.initState();
    AdService.loadRewardedAd(
      onLoaded: () {
        if (mounted) setState(() {});
      },
    );
  }

  void _handleTap() {
    if (AdService.isRewardedAdReady) {
      _showAd();
      return;
    }

    setState(() => _isLoadingOnTap = true);

    AdService.loadRewardedAd(
      onLoaded: () {
        if (!mounted) return;
        setState(() => _isLoadingOnTap = false);
        _showAd();
      },
      onFailed: () {
        if (!mounted) return;
        setState(() => _isLoadingOnTap = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ad not available right now, try again later.'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  void _showAd() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    AdService.showRewardedAd(
      onUserEarnedReward: () {
        userProvider.addBonusCoins(_rewardCoins);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎉 +20 coins added!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      onAdDismissed: () {},
      onAdFailedToShow: () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ad not available right now, try again later.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTappable = !_isLoadingOnTap;

    return GestureDetector(
      onTap: isTappable ? _handleTap : null,
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isTappable
                ? [
                    Colors.greenAccent.withValues(alpha: 0.7),
                    Colors.greenAccent.withValues(alpha: 0.25),
                  ]
                : [
                    Colors.grey.withValues(alpha: 0.15),
                    Colors.grey.withValues(alpha: 0.05),
                  ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isTappable
                ? Colors.greenAccent.withValues(alpha: 0.4)
                : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoadingOnTap
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white70,
                    ),
                  )
                : Icon(
                    Icons.card_giftcard_rounded,
                    color: isTappable ? Colors.white : Colors.white38,
                    size: 26,
                  ),
            const SizedBox(height: 6),
            Text(
              _isLoadingOnTap ? 'Loading...' : 'Bonus Coins 🎁',
              style: TextStyle(
                color: isTappable ? Colors.white : Colors.white38,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
