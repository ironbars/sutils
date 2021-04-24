Name:           sutils
Version:        0.1.0
Release:        1%{?dist}
Summary:        Script generation program
License:        BSD

URL:            https://github.com/ironbars/%{name}
Source0:        https://github.com/ironbars/%{name}/archive/refs/tags/v%{version}-alpha.tar.gz

Requires:       bash perl-interpreter
BuildArch:      noarch


%description
Script generator that uses a user-defined template to make new scripts.  Other 
utilities are provided that allow you to edit and distribute your custom 
scripts.


%prep
%global compdir %{_prefix}/share/bash-completion/completions
%global pkglibdir %{_prefix}/lib/%{name}
%setup -q -n %{name}-%{version}-alpha


%build


%install
mkdir -p %{buildroot}/%{_bindir}
mkdir -p %{buildroot}/%{compdir}
mkdir -p %{buildroot}/%{pkglibdir}
install -m 0755 bin/sgen %{buildroot}/%{_bindir}/sgen
install -m 0755 bin/sedit %{buildroot}/%{_bindir}/sedit
install -m 0755 bin/sdist %{buildroot}/%{_bindir}/sdist
install -m 0755 bin/ledit %{buildroot}/%{_bindir}/ledit
install -m 0644 lib/%{name}.sh %{buildroot}/%{pkglibdir}/%{name}.sh
install -m 0644 lib/sdist.sh %{buildroot}/%{pkglibdir}/sdist.sh
install -m 0644 lib/template %{buildroot}/%{pkglibdir}/template
install -m 0644 completion.d/%{name} %{buildroot}/%{compdir}/%{name}


%files
%license LICENSE
%dir %{pkglibdir}
%{_bindir}/sgen
%{_bindir}/sedit
%{_bindir}/sdist
%{_bindir}/ledit
%{pkglibdir}/template
%{pkglibdir}/%{name}.sh
%{pkglibdir}/sdist.sh
%{compdir}/%{name}


%changelog
* Sun Apr 18 2021 mpatton
- 
