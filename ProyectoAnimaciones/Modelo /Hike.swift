//
//  Hike.swift
//  ProyectoAnimaciones
//
//  Created by Dnilson Achahuanco on 16/06/25.
//
import Foundation

struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var photo: String // <-- OBLIGATORIO: Debe estar en el JSON
    var description: String // <-- OBLIGATORIO: Debe estar en el JSON
    var distance: Double
    var difficulty: Int
    var observations: [Observation]

    static var formatter = LengthFormatter()

    var distanceText: String {
        Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }

    struct Observation: Codable, Hashable {
        var distanceFromStart: Double

        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>

        // --- NECESARIO para decodificar Range<Double> de un Array en JSON ---
        private enum CodingKeys: String, CodingKey {
            case distanceFromStart
            case elevation
            case pace
            case heartRate
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            distanceFromStart = try container.decode(Double.self, forKey: .distanceFromStart)

            let elevationArray = try container.decode([Double].self, forKey: .elevation)
            guard elevationArray.count == 2 else {
                throw DecodingError.dataCorruptedError(forKey: .elevation,
                    in: container,
                    debugDescription: "Elevation array must contain exactly two doubles (min, max).")
            }
            elevation = elevationArray[0]..<elevationArray[1]

            let paceArray = try container.decode([Double].self, forKey: .pace)
            guard paceArray.count == 2 else {
                throw DecodingError.dataCorruptedError(forKey: .pace,
                    in: container,
                    debugDescription: "Pace array must contain exactly two doubles (min, max).")
            }
            pace = paceArray[0]..<paceArray[1]

            let heartRateArray = try container.decode([Double].self, forKey: .heartRate)
            guard heartRateArray.count == 2 else {
                throw DecodingError.dataCorruptedError(forKey: .heartRate,
                    in: container,
                    debugDescription: "HeartRate array must contain exactly two doubles (min, max).")
            }
            heartRate = heartRateArray[0]..<heartRateArray[1]
        }

        // --- Opcional, pero bueno si también necesitas codificar de vuelta a JSON ---
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(distanceFromStart, forKey: .distanceFromStart)
            try container.encode([elevation.lowerBound, elevation.upperBound], forKey: .elevation)
            try container.encode([pace.lowerBound, pace.upperBound], forKey: .pace)
            try container.encode([heartRate.lowerBound, heartRate.upperBound], forKey: .heartRate)
        }
    }
}
