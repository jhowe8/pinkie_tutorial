import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:pinkie_tutorial/actors/pinkie.dart';
import 'package:pinkie_tutorial/blocs/score/score_bloc.dart';
import 'package:pinkie_tutorial/flame_layer/pinkie_game.dart';

class Treasure extends SpriteComponent
    with
        HasGameRef<PinkieGame>,
        CollisionCallbacks,
        FlameBlocListenable<ScoreBloc, ScoreState> {
  final Vector2 treasurePosition;
  Treasure({required this.treasurePosition})
      : super(position: treasurePosition, size: Vector2.all(100)) {
    debugMode = true;
  }

  late Sprite redGem;
  late Sprite pinkGem;
  late Sprite greenGem;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
    redGem = await gameRef.loadSprite('red_gem.png');
    pinkGem = await gameRef.loadSprite('pink_gem.png');
    greenGem = await gameRef.loadSprite('green_gem.png');

    sprite = redGem;
  }

  @override
  void onNewState(ScoreState state) {
    if (state.score == 1) {
      sprite = pinkGem;
    }
    super.onNewState(state);
  }

  @override
  void update(double dt) {
    // x += 1;
    // y += 1;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Pinkie) {
      gameRef.scoreBloc.add(IncreaseScoreEvent());
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
