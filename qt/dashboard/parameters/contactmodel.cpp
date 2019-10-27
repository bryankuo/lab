/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
#include <iostream>

#include "contactmodel.h"

ContactModel::ContactModel(QObject *parent ) : QAbstractListModel(parent)
{
#if defined ( QT_DEBUG )
    std::cout <<
	typeid(*this).name() << "::" << __func__ <<":"<< __LINE__
	<< std::endl;
#endif
    // m_contacts.append({ "Angel Hogan", "Chapel St. 368 ", "Clearwater" , "0311 1823993" });
    m_contacts.append({ 2, 1, 0, 1, 0, "0311 1823993" }); // NG
}

int ContactModel::rowCount(const QModelIndex &) const
{
    return m_contacts.count();
}

QVariant ContactModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < rowCount())
        switch (role) {
        case AlarmNoRole: return m_contacts.at(index.row()).alarmNo;
        case DisplayRole: return m_contacts.at(index.row()).display;
        case RecordRole: return m_contacts.at(index.row()).record;
        case BeepsRole: return m_contacts.at(index.row()).beeps;
        case VoiceRole: return m_contacts.at(index.row()).voice;
        case ContentRole: return m_contacts.at(index.row()).content;
        default: return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> ContactModel::roleNames() const
{
    static const QHash<int, QByteArray> roles {
        { AlarmNoRole, "alarmNo" },
        { DisplayRole, "display" },
        { RecordRole, "record" },
        { BeepsRole, "beeps" },
        { VoiceRole, "voice" },
        { ContentRole, "content" }
    };
    return roles;
}

QVariantMap ContactModel::get(int row) const
{
    const Contact contact = m_contacts.value(row);
    return {
	{"alarmNo", contact.alarmNo},
	{"display", contact.display},
	{"record", contact.record},
	{"beeps", contact.beeps},
	{"voice", contact.voice},
	{"content", contact.content}};
}

void ContactModel::append(const int &alarmNo, const int &display, const int &record, const int &beeps, const int &voice, const QString &content)
{
    int row = 0;
    while (row < m_contacts.count() /*&& fullName > m_contacts.at(row).fullName*/)
        ++row;
    beginInsertRows(QModelIndex(), row, row);
    m_contacts.insert(row, {alarmNo, display, record, beeps, voice, content});
    endInsertRows();
}

void ContactModel::set(int row, const int &alarmNo, const int &display, const int &record, const int &beeps, const int &voice, const QString &content)
{
    if (row < 0 || row >= m_contacts.count())
        return;

    m_contacts.replace(row, { alarmNo, display, record, beeps, voice, content });
    dataChanged(index(row, 0), index(row, 0),
	{ AlarmNoRole, DisplayRole, RecordRole, BeepsRole, VoiceRole, ContentRole });
}

void ContactModel::remove(int row)
{
    if (row < 0 || row >= m_contacts.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_contacts.removeAt(row);
    endRemoveRows();
}
