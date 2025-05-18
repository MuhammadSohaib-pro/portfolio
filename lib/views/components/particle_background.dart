import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/res/theme_helper.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class ParticleBackground extends StatefulWidget {
  final int numberOfParticles;
  final Widget child;
  final Color particleColor;
  final double maxParticleSize;

  const ParticleBackground({
    super.key,
    this.numberOfParticles = 70,
    required this.child,
    this.particleColor = AppColors.mainColor,
    this.maxParticleSize = 5.0,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> {
  final Random random = Random();
  late List<ParticleModel> particles;

  @override
  void initState() {
    particles = List.generate(widget.numberOfParticles, (index) {
      return ParticleModel(random, widget.maxParticleSize);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.scaffoolBgColorDark,
            ),
          ),
        ),
        // Add subtle gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.2, -0.3),
                radius: 1.2,
                colors: [
                  widget.particleColor.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: AnimatedBackground(
            particles: particles,
            particleColor: widget.particleColor,
          ),
        ),
        widget.child,
      ],
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final List<ParticleModel> particles;
  final Color particleColor;

  const AnimatedBackground({
    super.key,
    required this.particles,
    required this.particleColor,
  });

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<Duration>(
      tween: ConstantTween(Duration.zero),
      duration: const Duration(days: 1),
      builder: (context, value, child) {
        final time = Duration(
          milliseconds: DateTime.now().millisecondsSinceEpoch,
        );
        return CustomPaint(
          painter: ParticlePainter(particles, time, particleColor),
        );
      },
    );
  }
}

class ParticleModel {
  late MovieTween tween;
  late double size;
  late Duration duration;
  late Duration startTime;
  late double opacity;
  late double pulseRate;

  final Random random;
  final double maxSize;

  ParticleModel(this.random, this.maxSize) {
    _initialize(); // ensure fields are set during construction
  }

  void _initialize() {
    final startPosition = Offset(
      -0.2 + 1.4 * random.nextDouble(),
      -0.2 + 1.4 * random.nextDouble(),
    );
    final endPosition = Offset(
      -0.2 + 1.4 * random.nextDouble(),
      -0.2 + 1.4 * random.nextDouble(),
    );

    duration = 5.seconds + random.nextInt(30).seconds;
    startTime = Duration.zero;
    size = 1 + random.nextDouble() * maxSize;
    opacity = 0.2 + random.nextDouble() * 0.6;
    pulseRate = 0.5 + random.nextDouble() * 2.0;

    tween =
        MovieTween()
          ..tween(
            'x',
            Tween(begin: startPosition.dx, end: endPosition.dx),
            duration: duration,
          )
          ..tween(
            'y',
            Tween(begin: startPosition.dy, end: endPosition.dy),
            duration: duration,
          )
          ..tween(
            'opacity',
            Tween(begin: 0.0, end: opacity),
            duration: Duration(
              milliseconds: (duration.inMilliseconds * 0.3).toInt(),
            ),
          )
          ..tween(
            'fade',
            Tween(begin: opacity, end: 0.0),
            begin: Duration(
              milliseconds: (duration.inMilliseconds * 0.7).toInt(),
            ),
            duration: Duration(
              milliseconds: (duration.inMilliseconds * 0.3).toInt(),
            ),
          );
  }

  void restart({Duration? time}) {
    _initialize();
    startTime = time ?? Duration.zero;
  }

  void update(Duration time) {
    final elapsedTime = time - startTime;
    if (elapsedTime > duration) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<ParticleModel> particles;
  final Duration time;
  final Color particleColor;

  ParticlePainter(this.particles, this.time, this.particleColor);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.update(time);

      final progress =
          (time - particle.startTime).inMilliseconds /
          particle.duration.inMilliseconds;

      final movie = particle.tween.transform(progress);
      final position = Offset(
        movie.get('x') * size.width,
        movie.get('y') * size.height,
      );

      // Calculate pulse effect
      final pulseTime = DateTime.now().millisecondsSinceEpoch / 1000;
      final pulseFactor = 0.8 + (sin(pulseTime * particle.pulseRate) + 1) * 0.1;

      final actualOpacity = movie.get('opacity') ?? particle.opacity;
      final paint =
          Paint()
            ..color = particleColor.withValues(
              alpha: actualOpacity * pulseFactor,
            )
            ..style = PaintingStyle.fill;

      canvas.drawCircle(position, particle.size * pulseFactor, paint);

      // Add a subtle glow effect
      if (particle.size > 3) {
        final glowPaint =
            Paint()
              ..color = particleColor.withValues(alpha: actualOpacity * 0.3)
              ..style = PaintingStyle.fill
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);

        canvas.drawCircle(
          position,
          particle.size * 1.5 * pulseFactor,
          glowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
