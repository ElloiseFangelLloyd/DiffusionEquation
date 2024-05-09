module timings 
    character(8) :: date
    character(10) :: time
    character(5) :: zone
    double precision :: wall_time
    double precision :: cpu_time_start 
    double precision :: cpu_time_end 
    integer :: count 
    integer :: count_final
    integer :: count_rate 
contains 
subroutine print_runtimes(count, count_final, count_rate, cpu_time_start, cpu_time_end, wall_time)
    double precision :: wall_time
    double precision :: cpu_time_start 
    double precision :: cpu_time_end 
    double precision :: cpu_total
    integer :: count 
    integer :: count_final
    integer :: count_rate 
    wall_time = (dble(count_final) - dble(count))/dble(count_rate) 
    print*,'Walltime is: ',wall_time,' seconds' 
    cpu_total = cpu_time_end - cpu_time_start
    print*,'CPU time is: ',cpu_total, ' seconds'
end subroutine print_runtimes

subroutine print_date_time()
    character(8) :: date
    character(10) :: time
    character(5) :: zone
    call date_and_time(date,time,zone)
    print*, 'The date is: ', date(7:8),'/',date(5:6),'/',date(1:4) 
    print*,'The time is: ', time(1:2), ':',time(3:4), '.',time(5:6)
end subroutine print_date_time

subroutine start_timer(count, cpu_time_start)
    integer :: count 
    double precision :: cpu_time_start
    call system_clock(count)
    call cpu_time(cpu_time_start)
end subroutine start_timer

subroutine stop_timer(count_final, count_rate, cpu_time_end) 
    integer :: count_final, count_rate
    double precision :: cpu_time_end
    call system_clock(count_final, count_rate)
    call cpu_time(cpu_time_end)
end subroutine stop_timer 

end module timings