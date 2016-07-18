#ifndef SCREENSHOTIMGPROVIDER_H
#define SCREENSHOTIMGPROVIDER_H

#include <QQuickImageProvider>
#include <QPixmap>

class ScreenShotImgProvider : public QQuickImageProvider
{
public:
    ScreenShotImgProvider(QPixmap getScreenshot);
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);

private:
    QPixmap mScreenshot;
};

#endif // SCREENSHOTIMGPROVIDER_H
