#
# spec file for package trento-checks
#
# Copyright (c) 2024 SUSE LLC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#


%define         trento_dir %{_datadir}/trento
%define         trento_checks_dir %{trento_dir}/checks
Name:           trento-checks
# Set by _service via OBS and GitHub action "CI"
Version:        0
Release:        0
Summary:        Checks for the Trento checks engine
License:        GPL-3.0-or-later
Group:          System/Monitoring
URL:            https://github.com/trento-project/checks
# Added by _service via OBS
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

%description
%{summary}

%prep
%autosetup -p1

%build
# empty on purpose

%install
install -d -m 0755 %{buildroot}%{trento_dir}
install -d -m 0755 %{buildroot}%{trento_checks_dir}
install -p -m 0644 checks/* %{buildroot}%{trento_checks_dir}

%files
%license LICENSE
%dir %{trento_dir}
%dir %{trento_checks_dir}

%changelog
