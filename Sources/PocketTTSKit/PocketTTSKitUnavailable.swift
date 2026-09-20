#if !canImport(CoreAI)
import Foundation

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
