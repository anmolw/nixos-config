{
  config,
  lib,
  pkgs,
  ...
}:
let
  pw_rnnoise_config = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Canceling source";
          "media.name" = "Noise Canceling source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_stereo";
                "control" = {
                  "VAD Threshold (%)" = 50.0;
                };
              }
            ];
          };
          "audio.position" = [
            "FL"
            "FR"
          ];
          "capture.props" = {
            "node.name" = "effect_input.rnnoise";
            "node.passive" = true;
          };
          "playback.props" = {
            "node.name" = "effect_output.rnnoise";
            "media.class" = "Audio/Source";
          };
        };
      }
    ];
  };
  pw_sourceamp_config = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "flags" = [ "nofail" ];
        "args" = {
          "node.description" = "Amplified mic source";
          "media.name" = "Amplified mic source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "builtin";
                "name" = "mic_gain";
                "label" = "bq_highshelf";
                "control" = {
                  "Freq" = 0;
                  "Q" = 1.0;
                  "Gain" = 14.4;
                };
              }
            ];
          };
          "capture.props" = {
            "node.passive" = true;
            "audio.position" = [ "MONO" ];
          };
          "playback.props" = {
            "node.name" = "effect_output.micgain";
            "audio.position" = [ "MONO" ];
            "media.class" = "Audio/Source";
          };
        };
      }
    ];
  };
in
{
  services.pipewire.extraConfig.pipewire = {
    "90-mic-gain" = pw_sourceamp_config;
    "10-allowed-rates" = {
      "context.properties" = {
        "default.clock.allowed-rates" = [
          44100
          48000
          88200
          96000
        ];
      };
    };
  };
  services.pipewire.extraConfig.client = {
    "10-resample-quality" = {
      "stream.properties" = {
        "resample.quality" = 10;
      };
    };
  };
}
