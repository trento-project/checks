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
Source:         https://github.com/trento-project/checks/archive/refs/heads/main.tar.gz
Group:          System/Monitoring
BuildArch:      noarch

%define         trento_dir %{_datadir}/trento
%define         trento_checks_dir %trento_dir/checks.d

%description
%{summary}

%prep
%autosetup -p1 n trento-checks

%install
install -d -m 0755 %buildroot%trento_dir
install -d -m 0755 %buildroot%trento_checks_dir
install -p -m 0644 checks/* %buildroot%trento_checks_dir

%files
%license LICENSE
%dir %trento_dir
%dir %trento_checks_dir

%trento_checks_dir/00081D.yaml
%trento_checks_dir/0B6DB2.yaml
%trento_checks_dir/156F64.yaml
%trento_checks_dir/15F7A8.yaml
%trento_checks_dir/205AF7.yaml
%trento_checks_dir/21FCA6.yaml
%trento_checks_dir/222A57.yaml
%trento_checks_dir/24ABCB.yaml
%trento_checks_dir/32CFC6.yaml
%trento_checks_dir/33403D.yaml
%trento_checks_dir/373DB8.yaml
%trento_checks_dir/49591F.yaml
%trento_checks_dir/53D035.yaml
%trento_checks_dir/61451E.yaml
%trento_checks_dir/68626E.yaml
%trento_checks_dir/6E9B82.yaml
%trento_checks_dir/790926.yaml
%trento_checks_dir/7E0221.yaml
%trento_checks_dir/816815.yaml
%trento_checks_dir/822E47.yaml
%trento_checks_dir/845CC9.yaml
%trento_checks_dir/9FAAD0.yaml
%trento_checks_dir/9FEFB0.yaml
%trento_checks_dir/A1244C.yaml
%trento_checks_dir/B089BE.yaml
%trento_checks_dir/C3166E.yaml
%trento_checks_dir/C620DC.yaml
%trento_checks_dir/CAEFF1.yaml
%trento_checks_dir/D028B9.yaml
%trento_checks_dir/D78671.yaml
%trento_checks_dir/DA114A.yaml
%trento_checks_dir/DC5429.yaml
%trento_checks_dir/F50AF5.yaml
%trento_checks_dir/FB0E0D.yaml

%changelog
