add_executable(what_time)
target_sources(what_time PRIVATE what_time.cc)
target_link_libraries(what_time PRIVATE absl::time spdlog::spdlog)
