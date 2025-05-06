#ifndef LOGHELPER_H
#define LOGHELPER_H

#include <string>

class LogHelper {
public:
    static void logMessage(const std::string &subPath, const std::string &message, bool checkLimit = false);
    static void logError(const std::string &subPath, const std::string &errorMessage, bool checkLimit = false);
    static std::string getLogFilePath(const std::string &app_locale);
    static void checkAndClearLogFile(const std::string &filePath);

private:
    static std::string getCurrentDateTime();
};

#endif // LOGHELPER_H
