class RingBuffer // queue
{
  Steps[] buf;
  int start;
  int end;

  RingBuffer(int sz)
  {
    buf = new Steps[sz];
    start = 0;
    end = 0;
  }
  
  boolean isempty()
  {
    return start == end;
  }

  void clr()
  {
    start = 0;
    end = 0;
  }

  void push(Steps val)
  {
    buf[end] = val;
    end = (end + 1) % buf.length;
  }
  
  Steps pop()
  {
    Steps val = buf[start];
    start = (start + 1) % buf.length;
    return val;
  }
}
