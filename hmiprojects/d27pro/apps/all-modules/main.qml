﻿import QtQuick 2.3

import Apps 1.0
import TheXPresenter 1.0
import Bluetooth 1.0
import TheXSettings 1.0
import TheXRadio 1.0
import TheXAudio 1.0
import TheXAux 1.0
import TheXMcan 1.0
import TheXDevice 1.0
import TheXFolder 1.0
import TheXImage 1.0
import TheXMusic 1.0
import TheXVideo 1.0
import TheXWifi 1.0
import TheXCarlife 1.0
import TheXEcolink 1.0
import TheXMirrorlink 1.0
import TheXMRev 1.0
import TheXUsbIfCer 1.0
import TheXMcanDiag 1.0
import TheXPower 1.0

import 'qrc:/Instances/Core' as ICore
import 'qrc:/Instances/Controls' as IControls
import 'qrc:/UI/JSLibs/JSCommon/Constant.js' as Constant

ICore.Window {
    id: window

    modeConfigs: ({
                      radio: HmiCommon.SourceRadio,
                      usb: {
                          info: {
                              'usbStateDialog': HmiCommon.SourceUSBMP3,
                              'music_playing' : HmiCommon.SourceUSBMP3,
                              'video_playing' : { src: HmiCommon.SourceUSBVideo, bound: Constant._PAGE_BOUND_EXIST }
                          },
                          guard: (function() {
                              return ((HSPluginsManager.get('devctl').deviceInfo.devState === Constant._DEVICE_STATE_INSERT ||
                                       HSPluginsManager.get('devctl').deviceInfo.devState === Constant._DEVICE_STATE_UNKNOWN)
                                      && HSPluginsManager.get('devctl').deviceInfo.devType === Constant._DEVICE_TYPE_UDISK)
                          }),
                          opts: (function() {
                              return (HmiCommon.isSourceExist(HmiCommon.SourceUSBMP3) && (HSPluginsManager.get('devctl').mediaInfo.mediaMusic > 0)) ?
                                     { needUpdate: true, properties: { initialPage: 'music_playing' } } : undefined
                          })
                      },
                      btaudio: {
                          info: HmiCommon.SourceBTA,
                          guard: (function() { return ((HSPluginsManager.get('btctl').connectState & 0x0f) === 0x01) })
                      },
                      aux: {
                          info: HmiCommon.SourceAUX,
                          guard: (function() { return HSPluginsManager.get('aux').auxReady })
                      },
                      carlife: {
                          info: { src: HmiCommon.SourceCarLife },
                          guard: (function() {
                              return (HSPluginsManager.get('devctl').deviceInfo.devState === Constant._DEVICE_STATE_INSERT
                                      && (HSPluginsManager.get('devctl').deviceInfo.devType === Constant._DEVICE_TYPE_CARPLAY ||
                                          HSPluginsManager.get('devctl').deviceInfo.devType === Constant._DEVICE_TYPE_ANDROID)
                                      && (HSPluginsManager.get('system').mobileState === 1))
                          })
                      },
                      ecolink: {
                          info: { src: HmiCommon.SourceECOLink },
                          guard: (function() {
                              return (HSPluginsManager.get('devctl').deviceInfo.devState === Constant._DEVICE_STATE_INSERT
                                      && (HSPluginsManager.get('devctl').deviceInfo.devType === Constant._DEVICE_TYPE_CARPLAY ||
                                          HSPluginsManager.get('devctl').deviceInfo.devType === Constant._DEVICE_TYPE_ANDROID)
                                      && (HSPluginsManager.get('system').mobileState === 2))
                          })
                      },
                      mirrorlink: {
                          info: { src: HmiCommon.SourceMirrLink },
                          guard: (function() {
                              return (HSPluginsManager.get('devctl').deviceInfo.devState === Constant._DEVICE_STATE_INSERT
                                      && (HSPluginsManager.get('devctl').deviceInfo.devType === Constant._DEVICE_TYPE_CARPLAY ||
                                          HSPluginsManager.get('devctl').deviceInfo.devType === Constant._DEVICE_TYPE_ANDROID)
                                      && (HSPluginsManager.get('system').mobileState === 3))
                          })
                      },
                      hfcall: {
                          info: { src: HmiCommon.SourceHF, bound: Constant._PAGE_BOUND_CURRENT },
                          guard: (function() {
                              if (multiApplications.currentApplication !== "hfcall") {
                                  switch (HSPluginsManager.get('btctl').telStatus) {
                                  case 1:
                                  case 2:
                                  case 3:
                                  case 5:
                                      return true
                                  default:
                                      break
                                  }
                              }
                              return false
                          })
                      }
                 })

    multiApplications {
        applications: ({
                           home      : { url: Qt.resolvedUrl('home/Application.qml')      , priority: 0, replace: true, title: qsTr('') },
                           radio     : { url: Qt.resolvedUrl('radio/Application.qml')     , priority: 2, replace: true, title: qsTr('收音机') },
                           hf        : { url: Qt.resolvedUrl('hf/Application.qml')        , priority: 2, replace: true, title: qsTr('蓝牙电话') },
                           hfcall    : { url: Qt.resolvedUrl('hf/ApplicationCall.qml')    , priority: 4, title: qsTr('蓝牙电话') },
                           calendar  : { url: Qt.resolvedUrl('calendar/Application.qml')  , priority: 2, replace: true, title: qsTr('日历') },
                           settings  : { url: Qt.resolvedUrl('settings/Application.qml')  , priority: 2, title: qsTr('Settings') },
                           usb       : { url: Qt.resolvedUrl('usb/Application.qml')       , priority: 2, replace: true, title: qsTr('USB') },
                           btaudio   : { url: Qt.resolvedUrl('btaudio/Application.qml')   , priority: 2, replace: true, title: qsTr('蓝牙音频') },
                           aux       : { url: Qt.resolvedUrl('theAUX/Application.qml')    , priority: 2, replace: true, title: qsTr('AUX') },
                           cm        : { url: Qt.resolvedUrl('cm/Application.qml')        , priority: 2, title: qsTr('连接管理') },
                           carlife   : { url: Qt.resolvedUrl('carlife/Application.qml')   , priority: 2, replace: true, title: qsTr('百度CarLife') },
                           ecolink   : { url: Qt.resolvedUrl('leecolink/Application.qml') , priority: 2, replace: true, title: qsTr('乐视ecolink') },
                           mirrorlink: { url: Qt.resolvedUrl('mirrorlink/Application.qml'), priority: 2, replace: true, title: qsTr('mirrorlink') },
                           wndlink   : { url: Qt.resolvedUrl('wndlink/Application.qml')   , priority: 1, replace: true, title: qsTr('WNDLink') },
                           manual    : { url: Qt.resolvedUrl('manual/Application.qml')    , priority: 2, replace: true, title: qsTr('东风手册') },
                           power     : { url: Qt.resolvedUrl('power/Application.qml')     , priority: 3, title: qsTr('Power') },
                           menu      : { url: Qt.resolvedUrl('menu/Application.qml')      , priority: 1, replace: true, title: qsTr('Menu') },
                           engineer  : { url: Qt.resolvedUrl('engineer/Application.qml')  , priority: 2, title: qsTr('工程模式')}
                       })
        initialApplication: 'home'
    }

    pluginsCreators: ({
                          radio     : radioCom,
                          aux       : auxCom,
                          btctl     : btCom,
                          system    : systemCom,
                          devctl    : devCom,
                          picturectl: pictureCom,
                          musicctl  : musicCom,
                          folderctl : folderCom,
                          videoctl  : videoCom,
                          wifictl   : wifiCom,
                          carlife   : carlifeCom,
                          ecolink   : leecolinkCom,
                          mirrorlink: mirrorlinkCom,
                          mcan      : mcanCom,
                          mrev      : mrevCom,
                          usbifcer  : usbifcerCom,
                          diag      : diagCom,
                          power     : powerCom
                      })

    pluginsSequence: ['mcan','mrev','power','system','wifictl','diag']

    PluginDecorator {
        id: decorator
        rcCounter: window
    }

    property alias decorator: decorator

    Component.onCompleted: {
        decorator.pluginMap = {
            radio: {
                rcId   : 'RadioCtl.openState',
                resume : HSPluginsManager.get('radio').plugin_radioOpen,
                pause  : HSPluginsManager.get('radio').plugin_radioClose,
                connect: (function(fr) { HSPluginsManager.get('radio').openStateChanged.connect(fr) }),
                cond   : (function() { return HSPluginsManager.get('radio').openState })
            },
            btctl: {
                rcId   : 'BtCtl.playbackstate',
                resume : HSPluginsManager.get('btctl').plugin_musicPlay,
                pause  : HSPluginsManager.get('btctl').plugin_musicPause
            },
            musicctl: {
                rcId   : 'MusicCtl.playState',
                resume : HSPluginsManager.get('musicctl').plugin_resume,
                pause  : HSPluginsManager.get('musicctl').plugin_pause
            },
            videoctl: {
                rcId   : 'VideoCtl.playState',
                resume : (function() {
                    HSPluginsManager.get('videoctl').setOverlay(1, 0x000001, 255)
                    HSPluginsManager.get('videoctl').plugin_resume()
                }),
                pause  : HSPluginsManager.get('videoctl').plugin_pause
            },
            carlife: {
                rcId   : 'CarlifeCtl.audioState',
                resume : HSPluginsManager.get('carlife').plugin_audioResume,
                pause  : HSPluginsManager.get('carlife').plugin_audioPause
            },
        }
        if (HSStore.datas.audioSource !== HmiCommon.SourceRadio) {
            HSStore.setData('RadioCtl.openState', false)
        }
    }

    /* BEGIN by Zhang Yi, 2016.11.10
     * If the current status is revState, screen touching shouldn't be responded.
     * See: Bug #93.
    */
    IControls.MouseArea {
        id: globeTouch
        anchors.fill: parent
        enabled: false
    }
    /* END - by Zhang Yi, 2016.11.10 */

    /* BEGIN by dengpang, 2016.12.7
    */
    Component {
        id: diagCom
        McanDiagCtl {
        }
    }
    /* END - by dengpang, 2016.12.7 */

    Component {
        id: powerCom
        PowerCtl {
        }
    }

    Component {
        id: radioCom
        RadioCtl {
            function radioOpen() {
                decorator.resume('radio')
            }

            function radioClose() {
                decorator.pause('radio')
            }

            function tryPause() {
                decorator.tryPause('radio', openState)
            }

            function tryResume(op) {
                decorator.tryResume('radio', op)
            }
        }
    }
    Component {
        id: auxCom
        AUXCtl {
        }
    }
    Component {
        id: btCom
        BtCtl {
            /* BEGIN by Zhang Yi, 2016.11.11
             * Optimizing the status changing of StatusBar.
            */
            id: btCtl
            Component.onCompleted: {
                statusBar.isBtOn = Qt.binding(function() {
                    return ((btCtl.powerState === 2) ? true : false)
                })
//                statusBar.isBtConnected = Qt.binding(function() {
//                    return (((btCtl.connectState & 0xf0) === 0x10) ? true : false)
//                })
            }
            /* BEGIN by Ge Wei, 2016.11.25 */
            onConnectStateChanged: {
                if((btCtl.connectState&0xf0) === 0x10 || (btCtl.connectState&0x0f) === 0x01) {
                    var battery = btCtl.connectedDevInfo.battery
                    statusBar.btUrl = setBtIcon(battery, 1)
                } else {
                    statusBar.btUrl ='qrc:/resources/home_Icon_BT_OFF.png'
                }
            }
            /* END - by Ge Wei, 2016.11.25 */

            onConnectedDevInfoChanged: {
                if((btCtl.connectState&0xf0) === 0x10 || (btCtl.connectState&0x0f) === 0x01){
                    var battery = btCtl.connectedDevInfo.battery
                    statusBar.btUrl = setBtIcon(battery,2)
                }
            }

            function setBtIcon(battery, type) {
                console.debug('statusBar type: ',type)
                console.debug('statusBar connectedDevInfo.battary: ',battery)
                if(battery !== undefined) {
                    if(battery < 1) {
                        return 'qrc:/resources/home_Icon_BT_ON_00.png'
                    } else if(battery < 2) {
                        return 'qrc:/resources/home_Icon_BT_ON_01.png'
                    } else if(battery < 3) {
                        return 'qrc:/resources/home_Icon_BT_ON_02.png'
                    } else if(battery < 5) {
                        return 'qrc:/resources/home_Icon_BT_ON_03.png'
                    } else {
                        return 'qrc:/resources/home_Icon_BT_ON_04.png'
                    }
                } else {
                    return 'qrc:/resources/home_Icon_BT_ON.png'
                }
            }

            /* END - by Zhang Yi, 2016.11.11 */

            function musicPlay() {
                decorator.resume('btctl')
            }

            function musicPause() {
                decorator.pause('btctl')
            }

            function tryPause() {
                decorator.tryPause('btctl', playbackstate === 1)
            }

            function tryResume(op) {
                decorator.tryResume('btctl', op)
            }
        }
    }
    Component {
        id: systemCom
        SystemCtl {
            /* BEGIN by Zhang Yi, 2016.11.11
             * Optimizing the status changing of StatusBar.
            */
            id: sysCtl
//            onHourChanged:    statusBar.updateTimeText()
//            onMinutesChanged: statusBar.updateTimeText()
            Component.onCompleted: {
                statusBar.timeFormt  = Qt.binding(function() { return sysCtl.hours24state   })
                statusBar.themeColor = Qt.binding(function() { return sysCtl.interfacemodel })
//                statusBar.updateTimeText()
            }
            /* END - by Zhang Yi, 2016.11.11 */
        }
    }
    Component {
        id: mcanCom
        McanCtl {
            /* BEGIN by Zhang Yi, 2016.11.11
             * Optimizing the status changing of StatusBar.
            */
            id: mcanCtl
            Component.onCompleted: {
                mcanCtl.getControl(0)
                statusBar.carTemperature = Qt.binding(function() { return mcanCtl.carTemperature })
            }
            /* END - by Zhang Yi, 2016.11.11 */
        }
    }
    Component {
        id:devCom
        DevCtl {
        }
    }
    Component {
        id:pictureCom
        PictureCtl{
        }
    }
    Component {
        id: musicCom
        MusicCtl {
            function next() {
                clearRc('MusicCtl.playState')
                plugin_next()
            }
            function previous() {
                clearRc('MusicCtl.playState')
                plugin_previous()
            }
            function resume() {
                decorator.resume('musicctl')
            }
            function pause() {
                decorator.pause('musicctl')
            }
            function tryPause() {
                decorator.tryPause('musicctl', playState === Constant._USB_MUSIC_PLAYING)
            }
            function tryResume(op) {
                decorator.tryResume('musicctl', op)
            }
        }
    }
    Component {
        id: videoCom
        VideoCtl {
            function resume() {
                decorator.resume('videoctl')
            }
            function pause() {
                decorator.pause('videoctl')
            }
            function tryPause() {
                decorator.tryPause('videoctl', playState === Constant._USB_MUSIC_PLAYING)
            }
            function tryResume(op) {
                decorator.tryResume('videoctl', op)
            }
        }
    }
    Component {
        id: folderCom
        FolderCtl{
        }
    }
    Component {
        id: wifiCom
        WifiCtl {
            /* BEGIN by Zhang Yi, 2016.11.11
             * Optimizing the status changing of StatusBar.
            */
            id: wifiCtl
            Component.onCompleted: {
                statusBar.isWifiOn = Qt.binding(function() {
                    return ((wifiCtl.powerstate === 0) ? false : true)
                })
            }
            /* END - by Zhang Yi, 2016.11.11 */
        }
    }
    Component {
        id: carlifeCom
        CarlifeCtl {
            function audioResume() {
                decorator.resume('carlife')
            }
            function audioPause() {
                decorator.pause('carlife')
            }
            function tryPause() {
                decorator.tryPause('carlife', audioState === 0)
            }
            function tryResume(op) {
                decorator.tryResume('carlife', op)
            }
        }
    }
    Component {
        id: leecolinkCom
        EcolinkCtl {
        }
    }
    Component{
        id: mirrorlinkCom
        MirrorlinkCtl{
        }
    }
    Component {
        id: mrevCom
        MrevCtl {
            /* BEGIN by Zhang Yi, 2016.11.10
             * If the current status is revState, screen touching shouldn't be responded.
             * See: Bug #93.
            */
            id: mrevCtl
            Component.onCompleted: {
                globeTouch.enabled = Qt.binding(function() {
                    console.debug("######################### mrevCtl.revStatus changed:", mrevCtl.revStatus)
                    return mrevCtl.revStatus
                })
            }
            /* END - by Zhang Yi, 2016.11.10 */
        }
    }

    Component {
        id: usbifcerCom
        UsbIfCerCtl {
        }
    }
}