#
# spec file for package trento-checks
#
# Copyright (c) 2024 SUSE LCC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.
#
# Please submit bugfixes or comments via https://bugs.opensuse.org/
#

Name:           trento-checks
Version:        0
Release:        0
Summary:        Checks for the Trento checks engine
License:        Apache-2.0
URL:            https://github.com/trento-project/checks
Group:          System/Monitoring
BuildArch:      noarch

%description
%{summay}

%prep
%autosetup -a1

%install

%files
%license LICENSE

%changelog
