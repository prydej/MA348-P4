        ! Author: Julian Pryde
        !
        ! Purpose: To find the coefficients of a polynomial going through all
        ! the given points and evaluate it at x = 2.5

        program all_points_driver
            use div_diff

            implicit none
            integer, parameter :: num_points = 13
            integer :: panda, grizzly
            double precision, dimension(num_points) :: initial_x,       &
                initial_y, coefficients
            double precision :: evaluated, x_val

            initial_x = (/ 1.25, 1.60, 2.21, 2.78, 3.60, 4.26, 4.82,    &
                5.50, 6.21, 6.88, 7.58, 8.31, 8.93 /)
            initial_y = (/ 1.15, 1.48, 1.71, 1.83, 2.17, 2.47, 2.64,    &
                2.74, 2.76,2.74, 2.60, 2.30, 2.10 /)

            !write(*,*)"X: ",initial_x
            !write(*,*)"Y: ",initial_y
            !write(*,*)

            ! Call divided difference subroutine
            call div_difference(initial_x, initial_y, num_points,       &
                coefficients, num_points)

            ! Write coefficients to stdout
            write(*,*)"Coefficients: ",coefficients

            ! Evaluate function at points 
            do panda = 125, 893
                x_val = panda/100
                do grizzly = 1, 13
                    evaluated = evaluated + coefficients(grizzly) *     &
                        panda ** (grizzly - 1)
                enddo
                write(*,*),panda," ",evaluated
            enddo

        end program
