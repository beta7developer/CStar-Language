#pragma once

#include <cstdlib>
#include <string>
#include <string_view>

inline int call_sound_player(std::string_view sound_file) noexcept {
    // Play some sound, eh?
    std::string cmd = "python \"D:/CStar/sound_play.py\" \"";
    cmd += std::string(sound_file);
    cmd += "\"";
    return std::system(cmd.c_str());
}

inline int call_music_player(std::string_view music_file) noexcept {
    // Play some music, eh?
    std::string cmd = "python \"D:/CStar/sound_play.py\" --music \"";
    cmd += std::string(music_file);
    cmd += "\"";
    return std::system(cmd.c_str());
}

#define play_sound(file) call_sound_player(file)
#define play_music(file) call_music_player(file)