@echo off
REM Run this from C:\depot\OCAP\Trunk
REM Bare minimum classpath

java -classpath _Test\IntegrationTests\HNavOnHydraRemoteTests\bin;^
_Test\IntegrationTests\NavigatorRemoteTestProxies\bin;^
_Test\IntegrationTests\NavigatorRemoteTests\bin;^
_Test\IntegrationTests\NavigatorRemoteTestUtil\bin;^
_Test\AutomatedTests\CAMPER\bin;^
jars\ftp4j-1.7.2.jar;^
RemoteTestInterface\bin;^
NavigatorRemoteTestStubs\bin;^
LastAssetMenu\bin;^
CID_AWT\bin;^
SDV\bin;^
VOD2\bin;^
Guide\bin;^
OdnStorageManager\bin;^
Tuner\bin;^
Commons\bin;^
Util\bin; ^
com.twc.ocap.rti.schedule.AirtimeCatalogScheduleTest

