import 'package:flutter/material.dart';

class PlanTab extends StatelessWidget {
  const PlanTab({super.key});

  void _showPaymentSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: MediaQuery.of(ctx).viewInsets,
          child: PaymentSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      children: [
        const Center(
          child: Text(
            '요금제',
            style: TextStyle(
              color: Color(0xFF176B5A),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // 요금제 비교 표
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(1.2),
          },
          border: TableBorder.symmetric(
            inside: BorderSide(color: Colors.grey.shade200),
          ),
          children: [
            TableRow(
              children: [
                const SizedBox(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '무료 요금제',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '프로 요금제',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            _planRow('영상 요약본의 저장이 가능한가요?', 'NO', 'YES'),
            _planRow('영상 스크립트도 다운받을 수 있나요?', 'NO', 'YES'),
            _planRow('영상에 사용된 제품정보를 알 수 있나요?', 'NO', 'YES'),
            _planRow('내 시간을 획기적으로 절약해주나요?', 'NO', 'YES'),
            _planRow('이용요금은 얼마인가요?', '무료', '5,000원/월'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey,
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('현재 이용중'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _showPaymentSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176B5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('이용하기'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const _PlanPoint(
          number: 1,
          title: '10분짜리 영상, 2분이면 다 볼 수 있습니다!',
          desc:
              '골프 레슨 영상에서 등장하는 나열된 정보들을 핵심만 추려서, 다양한 형태로 제공합니다.\n간편한 다운로드로 생각날 때마다 빠르게 찾아볼 수 있습니다.\n긴 영상 전체를 보며 소요되는 시간을 단축시켜드립니다.',
        ),
        const SizedBox(height: 24),
        const _PlanPoint(
          number: 2,
          title: '영상 속 이 제품, 바로 알려드립니다!',
          desc:
              '영상을 보면서, "저건 무슨 제품이지?" 생각해보신 적 있으시죠?\n저희가 정보를 찾아드립니다! 바로 확인 후 구매해보세요.',
        ),
        const SizedBox(height: 24),
        const _PlanPoint(
          number: 3,
          title: '오프라인에서도 출력해서 공부할 수 있습니다!',
          desc:
              '요약본 파일을 출력하고, 일상 속에서도 골프 공부를 편리하게 수행할 수 있어요.\n골프의 생활화를 도와드립니다!',
        ),
      ],
    );
  }
}

class PaymentSheet extends StatelessWidget {
  const PaymentSheet({super.key});

  void _showCompleteDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Center(
              child: Text(
                '안내',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            content: const Text(
              '결제가 완료되었습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176B5A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('닫기'),
                ),
              ),
            ],
          ),
    );
    Navigator.of(context).pop(); // 바텀시트 닫기
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 32,
                    color: Color(0xFF176B5A),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '프로 요금제(월간결제)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text('Golframe', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F8F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('시작일 : 오늘', style: TextStyle(fontSize: 15)),
                Text('1개월마다 결제', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F8F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('시작일 : 2025. 3. 20.', style: TextStyle(fontSize: 15)),
                Text(
                  '₩5,000/월',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '• Google Play의 정기 결제 페이지에서 언제든지 취소할 수 있습니다.',
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            '• 2025. 3. 20. 이전에 취소하면 요금이 청구되지 않습니다.',
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            '• 결제 수단에 임시 보류 금액이 표시될 수 있습니다.',
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            '• 다음 결제 일정이 시작되기 전에 결제 금액에 동의를 구하는 요청이 있을 예정입니다.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F8F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Text(
                  'VISA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(width: 12),
                Text('NH-0099', style: TextStyle(fontSize: 15)),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '"정기 결제"를 탭하면 취소할 때까지 정기 결제가 자동으로 갱신된다는 점에 동의하게 됩니다. 가격이 변경되면 알려드리겠습니다.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => _showCompleteDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176B5A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '정기 결제',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TableRow _planRow(String label, String free, String pro) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Text(label, style: const TextStyle(fontSize: 15)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          free,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: free == 'YES' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          pro,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight:
                pro == 'YES' || pro.contains('원')
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),
      ),
    ],
  );
}

class _PlanPoint extends StatelessWidget {
  final int number;
  final String title;
  final String desc;
  const _PlanPoint({
    required this.number,
    required this.title,
    required this.desc,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Point $number. $title',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          desc.replaceAll('\\n', '\n'),
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
