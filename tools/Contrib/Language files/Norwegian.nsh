;Language: Norwegian (2068)
;By Jonas Lindsrøm (jonasc_88@hotmail.com) Reviewed and fixed by Jan Ivar Beddari, d0der at online.no

!insertmacro LANGFILE "Norwegian" = "Norsk (trøndersk)" =

!ifdef MUI_WELCOMEPAGE
  ${LangFileString} MUI_TEXT_WELCOME_INFO_TITLE "Velkommen t veiviseren for installasjon av $(^NameDA) "
  ${LangFileString} MUI_TEXT_WELCOME_INFO_TEXT "Den veiviseren her vil vis dæ koss man installere $(^NameDA).$\r$\n$\r$\nDet anbefales at du avslutte dæm andre programman før du fortsette. Det vil la installasjonsprogrammet forandre på systemfilan din uten at du trøng å start datamaskina di på nytt.$\r$\n$\r$\n$_CLICK"
!endif

!ifdef MUI_UNWELCOMEPAGE
  ${LangFileString} MUI_UNTEXT_WELCOME_INFO_TITLE "Velkommen t veiviseren for avinstallasjon av $(^NameDA)"
  ${LangFileString} MUI_UNTEXT_WELCOME_INFO_TEXT "Den veiviseren her vil vis dæ koss man avinstallere $(^NameDA).$\r$\n$\r$\nFør du fortsette må du forsikre dæ om at $(^NameDA) itj kjøre fra før.$\r$\n$\r$\n$_CLICK"
!endif

!ifdef MUI_LICENSEPAGE
  ${LangFileString} MUI_TEXT_LICENSE_TITLE "Lisensavtale"
  ${LangFileString} MUI_TEXT_LICENSE_SUBTITLE "Vennligst les gjennom lisensavtalen før du starte installasjon av $(^NameDA)."
  ${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM "Hvis du godtar lisensavtalen så trøkk Godta for å fortsett. Du må godta lisensavtalen for å installer $(^NameDA)."
  ${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM_CHECKBOX "Hvis du godtar lisensavtalen, kryss av på merket under her. Du må godta lisensavtalen for å installer $(^NameDA). $_CLICK"
  ${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM_RADIOBUTTONS "Hvis du godtar lisensavtalen, velg det første alternativet oppå der. Du må godta lisensavtalen for å installer $(^NameDA). $_CLICK"
!endif

!ifdef MUI_UNLICENSEPAGE
  ${LangFileString} MUI_UNTEXT_LICENSE_TITLE "Lisensavtale"
  ${LangFileString} MUI_UNTEXT_LICENSE_SUBTITLE "Vennligst les gjennom lisensavtalen før du avinstallerer $(^NameDA)."
  ${LangFileString} MUI_UNINNERTEXT_LICENSE_BOTTOM "Hvis du godtar lisensavtalen så trøkk Godta for å fortsett.  Du må godta lisensavtalen for å avintallere $(^NameDA)."
  ${LangFileString} MUI_UNINNERTEXT_LICENSE_BOTTOM_CHECKBOX "Hvis du godtar lisensavtalen, kryss av på merket under. Du må godta lisensavtalen for å avinstaller $(^NameDA). $_CLICK"
  ${LangFileString} MUI_UNINNERTEXT_LICENSE_BOTTOM_RADIOBUTTONS "Hvis du godtar lisensavtalen, velg det første alternativet oppå der. Du må godta lisensavtalen for å avinstaller $(^NameDA). $_CLICK"
!endif

!ifdef MUI_LICENSEPAGE | MUI_UNLICENSEPAGE
  ${LangFileString} MUI_INNERTEXT_LICENSE_TOP "Trøkk på Page Down knappen for å sjå resten av lisensavtalen."
!endif

!ifdef MUI_COMPONENTSPAGE
  ${LangFileString} MUI_TEXT_COMPONENTS_TITLE "Velg dela"
  ${LangFileString} MUI_TEXT_COMPONENTS_SUBTITLE "Velg dæm delan av $(^NameDA) du har løst t å installer."
!endif

!ifdef MUI_UNCOMPONENTSPAGE
  ${LangFileString} MUI_UNTEXT_COMPONENTS_TITLE "Velg dela"
  ${LangFileString} MUI_UNTEXT_COMPONENTS_SUBTITLE "Velg dæm delan av $(^NameDA) du har løst t å avinstaller."
!endif

!ifdef MUI_COMPONENTSPAGE | MUI_UNCOMPONENTSPAGE
  ${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_TITLE "Beskrivels"
  !ifndef NSIS_CONFIG_COMPONENTPAGE_ALTERNATIVE
    ${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_INFO "Beveg musa over delan for å sjå beskrivelsa."
  !else
    ${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_INFO "Velg ein del for å sjå beskrivelsa."
  !endif
!endif

!ifdef MUI_DIRECTORYPAGE
  ${LangFileString} MUI_TEXT_DIRECTORY_TITLE "Velg installasjonsmapp"
  ${LangFileString} MUI_TEXT_DIRECTORY_SUBTITLE "Velg koss mapp du vil installer $(^NameDA) i."
!endif

!ifdef MUI_UNDIRECTORYPAGE
  ${LangFileString} MUI_UNTEXT_DIRECTORY_TITLE "Velg mapp for avinstallasjon"
  ${LangFileString} MUI_UNTEXT_DIRECTORY_SUBTITLE "Velg mappa du vil avinstaller $(^NameDA) fra."
!endif

!ifdef MUI_INSTFILESPAGE
  ${LangFileString} MUI_TEXT_INSTALLING_TITLE "Installasjon pågår"
  ${LangFileString} MUI_TEXT_INSTALLING_SUBTITLE "Vennligst slapp av mens $(^NameDA) bli installert."
  ${LangFileString} MUI_TEXT_FINISH_TITLE "Installasjon e ferdig"
  ${LangFileString} MUI_TEXT_FINISH_SUBTITLE "Installasjon vart fullført uten at vi såg nå feil."
  ${LangFileString} MUI_TEXT_ABORT_TITLE "Installasjon e avbrutt"
  ${LangFileString} MUI_TEXT_ABORT_SUBTITLE "Installasjon vart itj fullført skikkelig."
!endif

!ifdef MUI_UNINSTFILESPAGE
  ${LangFileString} MUI_UNTEXT_UNINSTALLING_TITLE "Avinstallasjon pågår"
  ${LangFileString} MUI_UNTEXT_UNINSTALLING_SUBTITLE "Vennligst vent mens $(^NameDA) bli avinstallert."
  ${LangFileString} MUI_UNTEXT_FINISH_TITLE "Avinstallasjon ferdig"
  ${LangFileString} MUI_UNTEXT_FINISH_SUBTITLE "Avinstallasjonen vart utført uten at vi såg nå feil."
  ${LangFileString} MUI_UNTEXT_ABORT_TITLE "Avinstallasjon avbrutt"
  ${LangFileString} MUI_UNTEXT_ABORT_SUBTITLE "Avinstallasjonen vart itj utført skikkelig."
!endif

!ifdef MUI_FINISHPAGE
  ${LangFileString} MUI_TEXT_FINISH_INFO_TITLE "Avslutte $(^NameDA) sin installasjonsveiviser"
  ${LangFileString} MUI_TEXT_FINISH_INFO_TEXT "$(^NameDA) e klart t bruk på datamaskina di.$\r$\n$\r$\nTrøkk på Ferdig for å avslutt installasjonsprogrammet."
  ${LangFileString} MUI_TEXT_FINISH_INFO_REBOOT "Du må start datamaskina på nytt for å fullfør installasjon av $(^NameDA). Vil du start datamaskina på nytt no?"
!endif

!ifdef MUI_UNFINISHPAGE
  ${LangFileString} MUI_UNTEXT_FINISH_INFO_TITLE "Fullføre avinstallasjon av $(^NameDA)"
  ${LangFileString} MUI_UNTEXT_FINISH_INFO_TEXT "$(^NameDA) har vorti avinstallert fra datamaskina di.$\r$\n$\r$\nTrøkk på Ferdig for å avslutt veiviseren her."
  ${LangFileString} MUI_UNTEXT_FINISH_INFO_REBOOT "Datamaskina må start på nytt for å fullfør avinstallasjon av $(^NameDA). Vil du start datamaskina på nytt no?"
!endif

!ifdef MUI_FINISHPAGE | MUI_UNFINISHPAGE
  ${LangFileString} MUI_TEXT_FINISH_REBOOTNOW "Ja. Start datamaskina på nytt no"
  ${LangFileString} MUI_TEXT_FINISH_REBOOTLATER "Nei. Æ vil start datamaskina på nytt seinar"
  ${LangFileString} MUI_TEXT_FINISH_RUN "&Kjør $(^NameDA) no med ein gang"
  ${LangFileString} MUI_TEXT_FINISH_SHOWREADME "&Vis mæ Readme fila"
  ${LangFileString} MUI_BUTTONTEXT_FINISH "&Ferdig"
!endif

!ifdef MUI_STARTMENUPAGE
  ${LangFileString} MUI_TEXT_STARTMENU_TITLE "Velg plassering på startmenyn"
  ${LangFileString} MUI_TEXT_STARTMENU_SUBTITLE "Velg koss mapp snarveian t $(^NameDA) ska ligg i."
  ${LangFileString} MUI_INNERTEXT_STARTMENU_TOP "Velg mapp for snarveian t programmet. Du kan også skriv inn et nytt navn for å lag ei ny mapp."
  ${LangFileString} MUI_INNERTEXT_STARTMENU_CHECKBOX "Itj lag nå snarveia"
!endif

!ifdef MUI_UNCONFIRMPAGE
  ${LangFileString} MUI_UNTEXT_CONFIRM_TITLE "Avinstaller $(^NameDA)"
  ${LangFileString} MUI_UNTEXT_CONFIRM_SUBTITLE "Fjern $(^NameDA) fra datamaskina di."
!endif

!ifdef MUI_ABORTWARNING
  ${LangFileString} MUI_TEXT_ABORTWARNING "E du heilt sekker på at du vil avslutt installasjon av $(^Name)?"
!endif

!ifdef MUI_UNABORTWARNING
  ${LangFileString} MUI_UNTEXT_ABORTWARNING "E du heilt sekker på at du vil avbryt avinstallasjon av $(^Name)?"
!endif

!ifdef MULTIUSER_INSTALLMODEPAGE
  ${LangFileString} MULTIUSER_TEXT_INSTALLMODE_TITLE "Velg brukera"
  ${LangFileString} MULTIUSER_TEXT_INSTALLMODE_SUBTITLE "Velg koss brukera du vil installer $(^NameDA) for."
  ${LangFileString} MULTIUSER_INNERTEXT_INSTALLMODE_TOP "Velg om du vil installer $(^NameDA) bare for dæ sjøl, eller for all som bruke maskina her. $(^ClickNext)"
  ${LangFileString} MULTIUSER_INNERTEXT_INSTALLMODE_ALLUSERS "Installer for all som bruke maskina her"
  ${LangFileString} MULTIUSER_INNERTEXT_INSTALLMODE_CURRENTUSER "Installer bare for mæ"
!endif
