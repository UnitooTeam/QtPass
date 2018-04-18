#ifdef QML_INTERFACE
#include <QQmlApplicationEngine>
#include <QIcon>
#else
#include "mainwindow.h"
#endif

#if SINGLE_APP
#include "singleapplication.h"
#endif

#include <QApplication>
#include <QTranslator>

/*! \mainpage QtPass
 *
 * \section intro_sec Introduction
 *
 * QtPass is a multi-platform GUI for pass, the standard unix password manager.
 *
 * https://qtpass.org/
 *
 * \section install_sec Installation
 *
 * \subsection dependencies Dependencies
 *
 * - QtPass requires Qt 4.8 or later, preferably Qt5.5 or later.
 * - The Linguist package is required to compile the translations.
 * - For use of the fallback icons the SVG library is required.
 *
 * At runtime the only real dependency is gpg2 but to make the most of it,
 * you'll need git and pass too.
 *
 * \subsection source From source
 *
 * On most *nix systems all you need is:
 *
 * `qmake && make && make install`
 */

/**
 * @brief main
 * @param argc
 * @param argv
 * @return
 */
int main(int argc, char *argv[]) {

#if QT_VERSION >= QT_VERSION_CHECK(5, 6, 0)
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#else
  qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "1");
#endif

  QString text = "";
  for (int i = 1; i < argc; ++i) {
    if (i > 1)
      text += " ";
    text += argv[i];
  }

  if ((text.indexOf("-psn_") == 0) || (text.indexOf("-session") == 0)) {
    text.clear();
  }

#if SINGLE_APP
  QString name = qgetenv("USER");
  if (name.isEmpty())
    name = qgetenv("USERNAME");
  SingleApplication app(argc, argv, name + "QtPass");
  if (app.isRunning()) {
    if (text.length() > 0)
      app.sendMessage(text);
    return 0;
  }
#else
  QApplication app(argc, argv);
#endif

  QCoreApplication::setOrganizationName("IJHack");
  QCoreApplication::setOrganizationDomain("ijhack.org");
  QCoreApplication::setApplicationName("QtPass");
  QCoreApplication::setApplicationVersion(VERSION);

  // Setup and load translator for localization
  QTranslator translator;
  QString locale = QLocale::system().name();
  // locale = "nl_NL";
  // locale = "he_IL";
  // locale = "ar_MA";
  translator.load(QString(":localization/localization_%1.qm").arg(locale));
  app.installTranslator(&translator);
  app.setWindowIcon(QIcon(":artwork/icon.png"));
  app.setLayoutDirection(QObject::tr("LTR") == "RTL" ? Qt::RightToLeft
                                                     : Qt::LeftToRight);

#ifdef QML_INTERFACE
  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  if (engine.rootObjects().isEmpty())
      return -1;
#else
  MainWindow w;

  app.setActiveWindow(&w);
  w.setApp(&app);
  w.setText(text);
  w.show();

  QObject::connect(&app, SIGNAL(aboutToQuit()), &w, SLOT(clearClipboard()));
#endif

  return app.exec();
}
