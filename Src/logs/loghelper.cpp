#include <fstream>
#include <chrono>
#include <iomanip>
#include <sstream>
#include <filesystem>
#include <windows.h>
#include "loghelper.h"
#include <Shlobj.h>
#include <iostream>

namespace fs = std::filesystem;

std::string LogHelper::getCurrentDateTime() {
    auto now = std::chrono::system_clock::now();
    auto time_t = std::chrono::system_clock::to_time_t(now);
    std::tm timeTm;
    localtime_s(&timeTm, &time_t);

    std::ostringstream oss;
    oss << std::put_time(&timeTm, "%Y-%m-%d %H:%M:%S");
    return oss.str();
}

std::string LogHelper::getLogFilePath(const std::string &subPath) {
    char appDataPath[MAX_PATH];
    if (SUCCEEDED(SHGetFolderPathA(NULL, CSIDL_APPDATA, NULL, 0, appDataPath))) {
        std::string logDir = std::string(appDataPath) + "\\Quanta\\Logs\\" + subPath;
        fs::create_directories(fs::path(logDir).parent_path());
        return logDir + ".txt";
    }
    return "";
}

void LogHelper::checkAndClearLogFile(const std::string &filePath) {
    std::ifstream logFile(filePath);
    if (!logFile.is_open()) {
        return;
    }

    int lineCount = 0;
    std::string line;
    while (std::getline(logFile, line)) {
        ++lineCount;
    }
    logFile.close();

    if (lineCount > 250) {
        std::ofstream clearFile(filePath, std::ios::trunc);
        clearFile.close();
    }
}

void LogHelper::logMessage(const std::string &subPath, const std::string &message, bool checkLimit) {
    std::string filePath = getLogFilePath(subPath);
    if (checkLimit) {
        checkAndClearLogFile(filePath);
    }

    std::ofstream logFile(filePath, std::ios::app);
    if (logFile.is_open()) {
        logFile << getCurrentDateTime() << " - INFO: " << message << std::endl;
    }
}

void LogHelper::logError(const std::string &subPath, const std::string &errorMessage, bool checkLimit) {
    std::string filePath = getLogFilePath(subPath);
    if (checkLimit) {
        checkAndClearLogFile(filePath);
    }

    std::ofstream logFile(filePath, std::ios::app);
    if (logFile.is_open()) {
        logFile << getCurrentDateTime() << " - ERROR: " << errorMessage << std::endl;
    }
}
