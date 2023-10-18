import 'dart:async';

import 'package:adventure/components/collection_block.dart';
import 'package:adventure/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  final String levelName;
  final Player player;
  late TiledComponent level;
  List<CollectionBlock> collectionBlocks = [];

  Level({
    required this.levelName,
    required this.player,
  });

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));

    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnpoint in spawnPointsLayer!.objects) {
        switch (spawnpoint.class_) {
          case 'Player':
            player.position = Vector2(spawnpoint.x, spawnpoint.y);
            // adding player
            add(player);
            break;
          default:
        }
      }

      final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

      if (collisionsLayer != null) {
        for (final collection in collisionsLayer!.objects) {
          switch (collection.class_) {
            case 'Platform':
              final platform = CollectionBlock(
                  position: Vector2(collection.x, collection.y),
                  size: Vector2(collection.width, collection.height),
                  isPlatform: true);
              collectionBlocks.add(platform);
              add(platform);
              break;
            default:
              final block = CollectionBlock(
                position: Vector2(collection.x, collection.y),
                size: Vector2(collection.width, collection.height),
              );
              collectionBlocks.add(block);
              add(block);
          }
        }
      }
    }
    player.collectionBlocks = collectionBlocks;
    return super.onLoad();
  }
}
