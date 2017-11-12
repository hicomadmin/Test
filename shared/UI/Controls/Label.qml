import QtQuick 2.3
import 'qrc:/UI/Controls' as Controls

Controls.Text {
    id: root

    property string language: _language
    property var langData: ({})
    readonly property var currentLangData: langData.hasOwnProperty(language) && langData[language]

    onCurrentLangDataChanged: if (typeof currentLangData !== 'undefined' && currentLangData) _resetProperties();
    onLanguageChanged: { text = qsTr(text); }

    function _resetProperties() {
        var property;
        var properties = currentLangData;
        if (properties) {
            for (var key in properties) {
                property = properties[key];
                if (root[key] !== undefined) {
                    if (typeof property === 'object') {
                        // is group properties
                        for (var subKey in property) {
                            if (root[key][subKey] !== undefined)
                                root[key][subKey] = property[subKey];
                        }
                    } else {
                        root[key] = property;
                    }
                }
            }
        }
    }
}
