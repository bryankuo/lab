#include "worker.h"
#include "controller.h"

void Controller::handleResults(const QString &)
{
    workerThread.quit();
    workerThread.wait();
}
