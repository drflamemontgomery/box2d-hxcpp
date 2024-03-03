package box2d;

#if box2d_user_settings
@:buildXml('
<files id="haxe">
  <compilerflag value="-DB2_USER_SETTINGS" />
</files>
<target id="haxe">
    <lib name="-lbox2d" />
</target>
')
#else
@:buildXml('
<target id="haxe">
    <lib name="-lbox2d" />
</target>
')
#end
@:keep class Include{

}
