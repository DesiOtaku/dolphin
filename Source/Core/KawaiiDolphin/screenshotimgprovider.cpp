#include "screenshotimgprovider.h"

ScreenShotImgProvider::ScreenShotImgProvider(QPixmap getScreenshot) : QQuickImageProvider(ImageType::Pixmap)
{
    mScreenshot = getScreenshot;
}

QPixmap ScreenShotImgProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) {
    return mScreenshot;
}
