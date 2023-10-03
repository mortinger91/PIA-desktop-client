// Copyright (c) 2023 Private Internet Access, Inc.
//
// This file is part of the Private Internet Access Desktop Client.
//
// The Private Internet Access Desktop Client is free software: you can
// redistribute it and/or modify it under the terms of the GNU General Public
// License as published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// The Private Internet Access Desktop Client is distributed in the hope that
// it will be useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with the Private Internet Access Desktop Client.  If not, see
// <https://www.gnu.org/licenses/>.

#include <common/src/common.h>
#line HEADER_FILE("dedicatedipcommand.h")

#ifndef DEDICATEDIPCOMMAND_H
#define DEDICATEDIPCOMMAND_H

#include "clicommand.h"

class DedicatedIpCommand : public CliCommand
{
public:
    virtual void printHelp(const QString &name) override;
    virtual int exec(const QStringList &params, QCoreApplication &app) override;

private:
    int execAdd(const QStringList &params, QCoreApplication &app);
    int execRemove(const QStringList &params, QCoreApplication &app);
};

#endif
