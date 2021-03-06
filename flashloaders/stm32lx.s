/***************************************************************************
 *   Copyright (C) 2010 by Spencer Oliver                                  *
 *   spen@spen-soft.co.uk                                                  *
 *                                                                         *
 *   Copyright (C) 2011 Øyvind Harboe                                      *
 *   oyvind.harboe@zylin.com                                               *
 *                                                                         *
 *   Copyright (C) 2011 Clement Burin des Roziers                          *
 *   clement.burin-des-roziers@hikob.com                                   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/


// Build : arm-eabi-gcc -c stm32lx.s
    .text
    .syntax unified
    .cpu cortex-m3
    .thumb
    .thumb_func
    .global write

/*
    r0 - source address
    r1 - destination address
    r2 - output, remaining word count
*/

    // Go to compare
    b test_done

write_word:
    // Load one word from address in r0, increment by 4
    ldr.w    ip, [r0], #4
    // Store the word to address in r1, increment by 4
    str.w    ip, [r1], #4
    // Decrement r2
    subs    r2, #1

test_done:
    // Test r2
    cmp     r2, #0
    // Loop if not zero
    bhi     write_word

    // Set breakpoint to exit
    bkpt    #0x00
