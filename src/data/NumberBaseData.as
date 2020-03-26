package data {
public class NumberBaseData {
    private var _nextBase:int;
    public function NumberBaseData() {
    }

    public function get nextBase():int {
        return _nextBase;
    }

    public function set nextBase(value:int):void {
        _nextBase = value;
    }
}
}
