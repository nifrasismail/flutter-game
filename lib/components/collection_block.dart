import 'package:flame/components.dart';

class CollectionBlock extends PositionComponent {
  bool isPlatform;
  CollectionBlock({position, size, this.isPlatform = false})
      : super(position: position, size: size) {
    // debugMode = true;
  }
}
