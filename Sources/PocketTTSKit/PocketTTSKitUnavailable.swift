#if !canImport(CoreAI)
import Foundation

public struct ChunkStat {
    public var text = ""
    public var nText = 0
    public var nWindows = 0
    public var posStart = 0
    public var headroom = 0
    public var maxGenLen = 0
    public var steps = 0
    public var frames = 0
    public var eosStep: Int?
    public var hitMaxGenLen = false
    public var framesAfterEOS = 0
    public var durationSeconds = 0.0
}

public struct SynthResult {
    public var samples: [Float] = []
    public var chunks: [ChunkStat] = []
    public var wallSeconds = 0.0
    public var prefillMillis = 0.0
    public var stepMillis = 0.0
    public var flowMillis = 0.0
    public var mimiMillis = 0.0
    public var lutMillis = 0.0
    public var marshalMillis = 0.0
    public var flattenMillis = 0.0
    public var engineCalls = 0
    public var gainApplied = 1.0

    public var hostMillis: Double { lutMillis + marshalMillis + flattenMillis }
    public var engineMillis: Double { prefillMillis + stepMillis + flowMillis + mimiMillis }
    public var otherMillis: Double { wallSeconds * 1000 - engineMillis - hostMillis }
    public var durationSeconds: Double { Double(samples.count) / Double(Model.sampleRate) }
    public var rtf: Double { wallSeconds / max(durationSeconds, 1e-9) }
}

private enum Unavailable {
    static let message = "Core AI TTS requires iOS 27 on a physical device."
}

/// Simulator-safe stub. Production synthesis lives in `TTSPipeline.swift` when Core AI is present.
public final class TTSPipeline {
    public let layout: WeightsLayout

    public init(assetsDir: URL, layout: WeightsLayout, dtype: String, unit: ComputeUnit) async throws {
        self.layout = layout
        throw TTSError.message(Unavailable.message)
    }

    public func synthesize(
        text: String,
        voice: VoiceState,
        seed: UInt64,
        applyGain: Bool
    ) async throws -> SynthResult {
        throw TTSError.message(Unavailable.message)
    }
}
#endif
