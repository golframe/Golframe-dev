import 'package:flutter/material.dart';

class SubscriptionHistoryScreen extends StatefulWidget {
  final VoidCallback onGoToPlanTab;
  const SubscriptionHistoryScreen({super.key, required this.onGoToPlanTab});

  @override
  State<SubscriptionHistoryScreen> createState() =>
      _SubscriptionHistoryScreenState();
}

class _SubscriptionHistoryScreenState extends State<SubscriptionHistoryScreen> {
  bool isPro = false; // 무료회원 테스트를 위해 false로 설정
  bool showCancelComplete = false;
  List<String> paymentHistory = []; // 결제이력 없음(무료회원)

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Center(
              child: Text(
                '안내',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            content: const Text(
              '구독을 해지하시겠습니까?\n다음 결제일부터 자동결제가 해지됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              SizedBox(
                width: 120,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF176B5A),
                    side: const BorderSide(color: Color(0xFFB7D6CE)),
                    backgroundColor: const Color(0xFFE6F2EF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('취소', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 120,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      isPro = false;
                      showCancelComplete = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06635C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('해지', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
    );
  }

  void _showCancelCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Center(
              child: Text(
                '구독 해지 완료',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            content: const Text(
              '구독 해지가 완료되었습니다.\n이용해주셔서 감사합니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              SizedBox(
                width: 180,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06635C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    '닫기',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _goToPlanTab() {
    Navigator.of(context).pop();
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onGoToPlanTab();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 무료회원 + 결제이력 없음: 오직 무료 요금제 카드 + 업그레이드 버튼만
    if (!isPro && paymentHistory.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            '구독 내역',
            style: TextStyle(
              color: Color(0xFF176B5A),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF176B5A)),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          children: [
            const SizedBox(height: 32),
            const Center(
              child: Text(
                '내 이용권 내역',
                style: TextStyle(
                  color: Color(0xFF176B5A),
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE6F2EF)),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '무료 요금제',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _goToPlanTab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06635C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text('요금제 업그레이드', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (showCancelComplete) {
        showCancelComplete = false;
        _showCancelCompleteDialog();
      }
    });
    // 무료회원 + 결제이력 있음: 무료 요금제+해지 안내+업그레이드 버튼+결제이력
    if (!isPro && paymentHistory.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            '구독 내역',
            style: TextStyle(
              color: Color(0xFF176B5A),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF176B5A)),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          children: [
            const SizedBox(height: 32),
            const Center(
              child: Text(
                '내 이용권 내역',
                style: TextStyle(
                  color: Color(0xFF176B5A),
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFE6F2EF)),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '무료 요금제',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F2EF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '구독 해지가 완료되었습니다.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _goToPlanTab,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06635C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text('요금제 업그레이드', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 32),
            for (final date in paymentHistory) ...[
              _buildHistoryCard(date),
              const SizedBox(height: 16),
            ],
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '구독 내역',
          style: TextStyle(
            color: Color(0xFF176B5A),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF176B5A)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        children: [
          const SizedBox(height: 32),
          const Center(
            child: Text(
              '내 이용권 내역',
              style: TextStyle(
                color: Color(0xFF176B5A),
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(height: 32),
          if (isPro) ...[
            _buildProCard(),
            const SizedBox(height: 16),
            const Text(
              '* 해당 구독은 인앱결제에서 결제한 구독으로,\n결제수단 변경은 인앱결제를 통해서 처리 가능합니다.',
              style: TextStyle(color: Color(0xFF8B95A1), fontSize: 15),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 32),
            for (final date in paymentHistory) ...[
              _buildHistoryCard(date),
              const SizedBox(height: 16),
            ],
          ] else if (paymentHistory.isNotEmpty) ...[
            _buildFreeCard(),
            const SizedBox(height: 32),
            for (final date in paymentHistory) ...[
              _buildHistoryCard(date),
              const SizedBox(height: 16),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildProCard() {
    // 프로회원 UI
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6F2EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '프로 요금제',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 8),
          const Text('결제금액 : 5,000원 / 인앱결제', style: TextStyle(fontSize: 16)),
          const Text(
            '결제일 : 2025.03.01 / 다음 결제일 : -',
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            '구독 기간 : 2025.03.01 ~ 2025.03.31',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: _showCancelDialog,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF176B5A),
                side: const BorderSide(color: Color(0xFF176B5A)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('자동결제 해지', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFreeCard() {
    // 무료회원 + 결제이력 있을 때만 해지 안내 노출
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFE6F2EF)),
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '무료 요금제',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE6F2EF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              '구독 해지가 완료되었습니다.',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _goToPlanTab,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF06635C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text('요금제 업그레이드', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(String date) {
    if (!isPro) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE6F2EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '프로 요금제',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text('결제금액 : 5,000원 / 인앱결제', style: TextStyle(fontSize: 15)),
          Text('결제일 : $date', style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
