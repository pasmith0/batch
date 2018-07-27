@echo off
REM Run this from C:\depot\OCAP\Trunk\_Test\IntegrationTests 
REM
REM May not need everything in the classpath
REM
REM Directories in _Test
REM AutomatedTests
REM build
REM docs
REM IntegrationTests
REM UnitTests

java -classpath NavigatorRemoteTestUtil\bin;^
NavigatorRemoteTestProxies\bin;^
..\..\AccessMenu\bin;^
..\..\Actions\bin;^
..\..\ALoader\bin;^
..\..\Analytics\bin;^
..\..\Animations\bin;^
..\..\Authorization\bin;^
..\..\BasicServicesStreaming\bin;^
..\..\Blocking\bin;^
..\..\BrickMode\bin;^
..\..\build\bin;^
..\..\CANH1.24.namespace\bin;^
..\..\CanhPodhWrapper\bin;^
..\..\CarouselMonitor\bin;^
..\..\Catalogs\bin;^
..\..\ChannelBanner\bin;^
..\..\ChannelContext\bin;^
..\..\ChannelPlayer\bin;^
..\..\ChannelPlayerRegistry\bin;^
..\..\CID_AWT\bin;^
..\..\Commons\bin;^
..\..\Config\bin;^
..\..\ConflictResolver\bin;^
..\..\Core\bin;^
..\..\CVP\bin;^
..\..\DAVICVODPortal\bin;^
..\..\Diags\bin;^
..\..\DialogServiceAWT\bin;^
..\..\DvrAnalytics\bin;^
..\..\DvrNavigator\bin;^
..\..\ExpressMenu\bin;^
..\..\FindShows\bin;^
..\..\Grid4StringsService\bin;^
..\..\GridProgramInfoCache\bin;^
..\..\Guide\bin;^
..\..\GuideUsageAnalytics\bin;^
..\..\Hardware\bin;^
..\..\HighlightBundleBlue\bin;^
..\..\HighlightBundleBlue16x9\bin;^
..\..\HighlightBundleYellow\bin;^
..\..\HighlightBundleYellow16x9\bin;^
..\..\HNavOnHydra\bin;^
..\..\HNavUtil\bin;^
..\..\hoth\bin;^
..\..\Hydra\bin;^
..\..\imaging\bin;^
..\..\installer\bin;^
..\..\IntegrityMonitor\bin;^
..\..\JakartaOro\bin;^
..\..\jars;^
..\..\Jetty6.1.26\bin;^
..\..\JettyStandAlone\bin;^
..\..\KeyEventManager\bin;^
..\..\keystore\bin;^
..\..\LastAssetMenu\bin;^
..\..\LastTunedChannels\bin;^
..\..\LegacyUI\bin;^
..\..\LiveStreaming\bin;^
..\..\Loading\bin;^
..\..\LoadingResources\bin;^
..\..\Logging\bin;^
..\..\LoggingAdapters\bin;^
..\..\LoggingWebPages\bin;^
..\..\LSVRestorer\bin;^
..\..\MainMenu\bin;^
..\..\MockStack\bin;^
..\..\Monitor\bin;^
..\..\MotoNetwork\bin;^
..\..\Navigator\bin;^
..\..\NavigatorData\bin;^
..\..\NavigatorLegacyConstants\bin;^
..\..\NavigatorLegacyResources\bin;^
..\..\NavigatorLegacyResources16x9\bin;^
..\..\NavigatorRemoteTestProxies\bin;^
..\..\NavigatorRemoteTestStubs\bin;^
..\..\Network\bin;^
..\..\newoutput\bin;^
..\..\ODNSL\bin;^
..\..\OdnStorageManager\bin;^
..\..\PlayList\bin;^
..\..\PPV\bin;^
..\..\PreemptiveMemoryMgmt\bin;^
..\..\PreludeAWT\bin;^
..\..\PreludeAWT2\bin;^
..\..\PreludeNetworkMonitor\bin;^
..\..\PreludeResources\bin;^
..\..\PreludeResources16x9\bin;^
..\..\PushServices\bin;^
..\..\RDVR\bin;^
..\..\Recommendations\bin;^
..\..\RecordingComponent\bin;^
..\..\ReminderTimer\bin;^
..\..\RemoteTestInterface\bin;^
..\..\Resource\bin;^
..\..\RtiCatalogSource\bin;^
..\..\SaCanhNetwork\bin;^
..\..\ScreenManager\bin;^
..\..\ScreenSaver\bin;^
..\..\SDV\bin;^
..\..\Settings\bin;^
..\..\ShowList\bin;^
..\..\SNMP\bin;^
..\..\SPPServices\bin;^
..\..\SQL\bin;^
..\..\STBMessaging\bin;^
..\..\ThirdPartyApp\bin;^
..\..\Timer\bin;^
..\..\TimeShiftBuffer\bin;^
..\..\TMC\bin;^
..\..\Tuner\bin;^
..\..\UMPBase\bin;^
..\..\UMPSettingsSaver\bin;^
..\..\Upsell\bin;^
..\..\Util\bin;^
..\..\VAF\bin;^
..\..\VersionService\bin;^
..\..\VideoControl\bin;^
..\..\VOD2\bin;^
..\..\WebImage\bin;^
..\..\Widget\bin;^
..\..\XMLParser\bin;^
..\AutomatedTests\CAMPER\bin;^
..\..\jars\ftp4j-1.7.2.jar ^
com.twc.ocap.rti.schedule.AirtimeCatalogScheduleTest

