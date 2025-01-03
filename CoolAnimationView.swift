//
//  CoolAnimationView.swift
//  MapTest
//
//  Created by 孫立明 on 2025/1/3.
//

import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var color: Color
    var size: CGFloat
}

struct CoolAnimationView: View {
    @State private var particles: [Particle] = []
    @State private var isAnimating = false

    var body: some View {
        ZStack {
//            Color.black.ignoresSafeArea()
            
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.size, height: particle.size)
                    .position(x: particle.x, y: particle.y)
                    .opacity(isAnimating ? 0 : 1) // 淡出效果
                    .animation(.easeOut(duration: 1.5), value: isAnimating)
            }
        }
        .onAppear {
            generateParticles()
            startAnimation()
        }
    }

    private func generateParticles() {
        let centerX = UIScreen.main.bounds.width / 2
        let centerY = UIScreen.main.bounds.height / 2
        
        for _ in 0..<100 {
            let randomColor = Color(hue: Double.random(in: 0...1),
                                    saturation: 1.0,
                                    brightness: 1.0)
            let randomSize = CGFloat.random(in: 5...15)
            particles.append(Particle(x: centerX, y: centerY, color: randomColor, size: randomSize))
        }
    }

    private func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isAnimating = true
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            for i in particles.indices {
                particles[i].x += CGFloat.random(in: -screenWidth...screenWidth)
                particles[i].y += CGFloat.random(in: -screenHeight...screenHeight)
            }
        }
    }
}

struct CoolAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CoolAnimationView()
    }
}
